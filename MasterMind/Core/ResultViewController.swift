//
//  ResultViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/8/22.
//

import UIKit



class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
  
    @IBOutlet weak var saveGameButton: UIButton!
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray2
        // Do any additional setup after loading the view.
        print("result view")
        resultLabel.text = result
        resultLabel.textColor = .black
        
        saveGameButton.backgroundColor = .green
        saveGameButton.setTitle("Test Button", for: .normal)
        saveGameButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
