//
//  BoardViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit

// this protocol allows us to take function to View controller
protocol BoardViewControllerDatasource: AnyObject {
    var currentGuesses: [[String?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var datasource: BoardViewControllerDatasource?
    
    //collection View setup
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        // view.backgroundColor = .red
        //add collectionView to boardView
        view.addSubview(collectionView)
        //constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    // function to reload collection view data
    public func reloadData() {
        collectionView.reloadData()
    }
}

// setup + design for BoardVC
extension BoardViewController {
    // return number of rows which is equal to rows in current guesses, if not found return 0
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }
    // return number of columns in each section, which will be the size of the guesses columns * 2 (double for the guess colors hint cells)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = datasource?.currentGuesses ?? []
        return guesses[section].count * 2
    }
    
    // cell configuration for certain cell in the BoardVC collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        
        // gets the color for the boxes from boxColor array from protocol
        cell.contentView.backgroundColor = datasource?.boxColor(at: indexPath)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        
        let guesses = datasource?.currentGuesses ?? []
        
        // this ensures only first 4 cells have the number show in the cell, as the others are only for color hints
        if indexPath.row < 4 {
            if let number = guesses[indexPath.section][indexPath.row] {
                cell.configure(with: number)
                return cell
            }
        }
        
        return cell
    }
    
    // sizing of certain cell in BoardVC collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 20
        
        var size: CGFloat = (collectionView.frame.size.width - margin)/6
        
        // different configuration for the last 4 cells (color hints)
        if indexPath.row > 3 {
            size = CGFloat(collectionView.frame.size.width - margin)/15
            return CGSize(width: size, height: size * 1.5)
        }
    
        return CGSize(width: size, height: size * 0.6)
    }
    //centering + spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    //tap on cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

