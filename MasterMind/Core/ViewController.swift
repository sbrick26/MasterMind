//
//  ViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

/*

 Main View Controller: This view will combine the BoardView and KeyboardView to present the entire game board to the user. This view will also have the logic for the game
 
*/

import UIKit

class ViewController: UIViewController {

    // Create view controller instances
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    // Utilize getUniqueRandomNumbers to set position for the color hints in BoardView
    let randomGuessIndex = Int.getUniqueRandomNumbers(min: 0, max: 3, count: 4)
    // Array of colors for the Board
    var guessColors: [[UIColor?]] = Array(repeating: Array(repeating: UIColor.systemGray, count: 4), count: 10)
    // Array to keep track of player guesses
    var guesses: [[String?]] = Array(repeating: Array(repeating: nil, count: 4), count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        // Task will wait for async function to execute before proceeding to load the game board elements. This ensures that the game code from the API is received before the player can start the game
        Task {
            try await RandomNumber.getData()
            print(Answer.answer)
            self.addChildren()
        }
    }
    
    // Resets the game by clearing the guesses and color hints arrays and then reloading the Data for the BoardViewController
    func resetGame() {
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                guesses[i][j] = nil
            }
        }
        for i in 0..<guessColors.count {
            for j in 0..<guessColors[i].count {
                guessColors[i][j] = UIColor.systemGray
            }
        }
        boardVC.reloadData()
        
    }

    // Adds Child views of BoardView and KeyboardView to mainView with allotted contraints
    func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.datasource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    // Adds constraints to both the BoardView and Keyboard view in relation to main view
    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    

}

// Extension VC as delegate allows us to control what happens when the user interacts with the UI of the KeyboardVC. This allows us to design game logic when the player tries to input a key

extension ViewController: KeyboardViewControllerDelegate {
    
    // Presents the ResultsVC upon win/loss to user
    func goToResultScreen(winResult: String) {
        print("new view here")
        
        let vc = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController)
        vc.result = winResult
        self.present(vc, animated: true, completion: nil)
    }
    
    // This function provides the main game logic when a user presses a key on our KeyBoardVC when user triggers didTapKey. The value from the action is passed into the function so we can access which number a player has selected, and then designate further logic upon a keypress
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey number: String) {
        //print(number)
        
        
        var stop = false
        
        // if new game is selected, the View will get a new code from Integer Generator API and reset the game
        if number == "New Game" {
            Task {
                try await RandomNumber.getData()
                print("MIDGAMESWITCH")
                print(Answer.answer)
                resetGame()
                
            }
        }
        // If user hits the delete key, we will check to see at which position of the current guess: if it is in the last position of the row, the player will not be able to delete the key.
        else if number == "Delete" {
            for i in (0..<guesses.count).reversed(){
                for j in (0..<4).reversed(){
                        if guesses [i][j] != nil {
                            
                            if j == 3 {
                                stop = true
                                break
                            }
                            guessColors[i][j] = .systemGray
                            guesses [i][j] = nil
                            stop = true
                            break
                        }
                    }
                    if stop {
                        break
                    }
            }
        }
        // if we are not in the last guess position of the row, the player will be able to delete the guess attempt
        else {
            for i in 0..<guesses.count {
                for j in 0..<4 {
                    if guesses [i][j] == nil {
                        //print(j)
                        guesses [i][j] = number
                        stop = true
                        // add colors of verification
                        if number == Answer.answer[j] {
                            guessColors[i][j] = .systemRed
                        } else {
                            for x in 0..<Answer.answer.count {
                                if Answer.answer[x] == number {
                                    guessColors[i][j] = .systemMint
                                }
                            }
                        }
                        break
                    }
                    
                }
                
                // check to see if the guess answer is the correct answer, and if so take the user to the results screen with Win result
                if guesses[i] == Answer.answer {
                    goToResultScreen(winResult: "You Win!!")
                }
                
                if stop {
                    break
                }
            }
        }
        
        boardVC.reloadData()
        
        
        // if the player did not guess correctly within 10 attempts, then player will see the Lose results screen
        if guesses[9][3] != nil {
            //new view
            goToResultScreen(winResult: "You Lost.")
        }
    }
}

// this extension allows us to correct guesses and colors inside our BoardVC cells
extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[String?]] {
        return guesses
    }
    
    // function to determine box color for the color hints
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        
        // modify only the last 4 cells this way
        if indexPath.row > 3 {
            let count = guesses[rowIndex].compactMap({ $0 }).count
            //print(count)
            guard count == 4 else {
                return nil
            }
            guard let number = guesses[indexPath.section][indexPath.row - 4] else {
                return nil
            }
            //print(randomGuessIndex)
            return guessColors[indexPath.section][randomGuessIndex[indexPath.row - 4]]
            
        }
        
        return .systemGray
    }
    
}

// extension of class Int to get a set of 4 unique random numbers from 0-3 to determine the order of the color hints in BoardVC

extension Int {

    static func getUniqueRandomNumbers(min: Int, max: Int, count: Int) -> [Int] {
        var set = Set<Int>()
        while set.count < count {
            set.insert(Int.random(in: min...max))
        }
        return Array(set)
    }

}



