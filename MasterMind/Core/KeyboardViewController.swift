//
//  KeyboardViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey number: String)
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: KeyboardViewControllerDelegate?
    let numbers = ["0123", "4567"]
    private var keys: [[String]] = []
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        // view.backgroundColor = .red
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        for row in numbers {
            //let nums = Array(row)
            let nums = row.map { String($0) }
            keys.append(nums)
            
        }
        keys.append(["Enter","Delete"])
        //print(keys)
        
    }
    

 

}

extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        let number = keys[indexPath.section][indexPath.row]
        cell.configure(with: number)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let margin: CGFloat = 20
        
        var size: CGFloat = (collectionView.frame.size.width - margin)/4
        
        //print(indexPath.section)
        
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
        
        var size: CGFloat = (collectionView.frame.size.width - margin)/4
        
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
    
    //tap on cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let number = keys[indexPath.section][indexPath.row]
        
        delegate?.keyboardViewController(self, didTapKey: number)
    }
}
