//
//  KeyCell.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit

class KeyCell: UICollectionViewCell {
    static let identifier = "KeyCell"
    
    // lebel design for all keycells used in collection views
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.textAlignment = .center
        label.font = UIFont (name: "American Typewriter", size: 18)
        //label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    // initilizer for KeyCell, here we add the label to the view and define constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
    
    // clear label.text
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set label.text to number 
    func configure(with number: String) {
        label.text = number
    }
}
