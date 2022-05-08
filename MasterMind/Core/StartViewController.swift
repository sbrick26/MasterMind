//
//  StartViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/8/22.
//

/*
 
Start View Controller: This view controller is the start point for the app

*/

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //startGameButton with segue in Main.storyboard to main View Controller
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Start View Design
        
        view.backgroundColor = .black
        titleLabel.textColor = .green
        startGameButton.titleLabel?.textColor = .black
        startGameButton.setTitleColor(.black, for: .normal)
        startGameButton.setTitleColor(.black, for: .selected)
    }
}
