//
//  ResultViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/8/22.
//

import UIKit



class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var saveGameButton: UIButton!
    @IBOutlet weak var winCountLabel: UILabel!
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        print("result view")
        print(Answer.answer)
        let answerDiag = "The code was: "
        var joinedAnswer = answerDiag + Answer.answer.joined()
        print(joinedAnswer)
        
        resultLabel.text = result
        resultLabel.textColor = .green
        answerLabel.text = joinedAnswer
        answerLabel.textColor = .green
        
        saveGameButton.setTitle("New Game", for: .normal)
        saveGameButton.setTitleColor(.black, for: .normal)
        saveGameButton.setTitleColor(.black, for: .highlighted)
        
        saveGameButton.titleLabel?.font =  UIFont(name: "American Typewriter", size: 20)
        saveGameButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        UserDefaults.standard.register(defaults: ["wincount": 0])
        if result == "You Win!!" {
            var currentScore = UserDefaults.standard.object(forKey: "wincount")
            currentScore = currentScore as! Int + 1
            print(currentScore)
            UserDefaults.standard.set(currentScore, forKey: "wincount")
        }
        
        var countString = String(UserDefaults.standard.object(forKey: "wincount") as! Int)
        print(countString)
        winCountLabel.text = "You have won " + countString + " games!"
        winCountLabel.textColor = .green
        
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        let presentedBy = presentingViewController as? ViewController
        
        Task {
            try await RandomNumber.getData()
            print("RESETANSWER")
            print(Answer.answer)
            presentedBy?.resetGame()
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    

}
