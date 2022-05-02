//
//  BoardViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit

protocol BoardViewControllerDatasource: AnyObject {
    var currentGuesses: [[String?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var datasource: BoardViewControllerDatasource?
    
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
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
 

}

extension BoardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = datasource?.currentGuesses ?? []
        return guesses[section].count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        
        /* if indexPath.row > 3 {
         cell.configure(with: "")
         return cell
     }*/
        //cell.configure(with: "9")
        cell.contentView.backgroundColor = datasource?.boxColor(at: indexPath)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        
        let guesses = datasource?.currentGuesses ?? []
        
        if indexPath.row < 4 {
            if let number = guesses[indexPath.section][indexPath.row] {
                cell.configure(with: number)
                return cell
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 20
        
        var size: CGFloat = (collectionView.frame.size.width - margin)/6
        
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

