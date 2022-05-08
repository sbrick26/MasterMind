//
//  StartViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/8/22.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        titleLabel.textColor = .green
        startGameButton.titleLabel?.textColor = .black
        startGameButton.setTitleColor(.black, for: .normal)
        startGameButton.setTitleColor(.black, for: .selected)
        // Do any additional setup after loading the view.
    }

}
