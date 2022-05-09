//
//  KeyboardViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit

// this protocol allows us to take function to View controller
protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey number: String)
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: KeyboardViewControllerDelegate?
    let numbers = ["0123", "4567"]
    var keys: [[String]] = []
    //collection view setup
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assign delegate and datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        //add collection view to View and define constraints
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        //array to take numbers as individual keys
        for row in numbers {
            //let nums = Array(row)
            let nums = row.map { String($0) }
            keys.append(nums)
        }
        //adds buttons to key set
        keys.append(["New Game","Delete"])
    }
}

// setup + design for KeyboardVC
extension KeyboardViewController {
    
    // function to return number of row for Keyboard collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    // function to return number of columns for Keyboard collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    // cell configuration for each cell at a certain position
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // protected cell assignments or throw error
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        //the number of the cell
        let number = keys[indexPath.section][indexPath.row]
        cell.configure(with: number)
        return cell
    }
    
    // function for the sizing and margins of a ccertain cell for Keyboard collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let margin: CGFloat = 20
        
        //evenly spaces cells based on how many keys are in the row
        var size: CGFloat = (collectionView.frame.size.width - margin)/CGFloat(numbers[0].count)
        
        //print(indexPath.section)
        
        // checks if it is the last row, since those will be formatted differently
        if indexPath.section > 1 {
            size = CGFloat((collectionView.frame.size.width - margin)/2)
            return CGSize(width: size, height: size * 0.3)
        }
        return CGSize(width: size, height: size * 0.6)
    }
    //centering + spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var left: CGFloat = 1
        var right: CGFloat = 1
        
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        let margin: CGFloat = 20
        
        var size: CGFloat = (collectionView.frame.size.width - margin)/CGFloat(numbers[0].count)
        
        //calculate margin with inter spacing
        var inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count))/2
        left = inset
        right = inset
        if section > 1 {
            size = CGFloat((collectionView.frame.size.width - margin)/2)
            
            //calculate margin with inter spacing
            inset = CGFloat((collectionView.frame.size.width - (size * count) - (2 * count))/2)
            left = inset
            right = inset
            return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
        }
        return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
    }
    
    //tap on cell - did select certain cell on Keyboard collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //deselect item
        collectionView.deselectItem(at: indexPath, animated: true)
        let number = keys[indexPath.section][indexPath.row]
        
        //send this number to KeyboardVC delegate for didTapKey
        delegate?.keyboardViewController(self, didTapKey: number)
    }
}
