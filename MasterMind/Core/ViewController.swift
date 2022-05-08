//
//  ViewController.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/1/22.
//

import UIKit


class ViewController: UIViewController {

    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    let randomGuessIndex = Int.getUniqueRandomNumbers(min: 0, max: 3, count: 4)
    
    var guessColors: [[UIColor?]] = Array(repeating: Array(repeating: UIColor.systemGray, count: 4), count: 10)
    var guesses: [[String?]] = Array(repeating: Array(repeating: nil, count: 4), count: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        
        Task {
            try await RandomNumber.getData()
            print(Answer.answer)
            self.addChildren()
        }
        
        
    }
    
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

extension ViewController: KeyboardViewControllerDelegate {
    
    func goToResultScreen(winResult: String) {
        print("new view here")
        
        let vc = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController)
        vc.result = winResult
        self.present(vc, animated: true, completion: nil)
    }
    
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey number: String) {
        //print(number)
        
        //update guesses add the color adding here
        var stop = false
        
        if number == "Delete" {
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
                
                if guesses[i] == Answer.answer {
                    goToResultScreen(winResult: "You Win!!")
                }
                
                if stop {
                    break
                }
            }
        }
        
        boardVC.reloadData()
        
        
        
        if guesses[9][3] != nil {
            //new view
            goToResultScreen(winResult: "You Lost.")
        }
    }
}

extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[String?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        
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

extension Int {

    static func getUniqueRandomNumbers(min: Int, max: Int, count: Int) -> [Int] {
        var set = Set<Int>()
        while set.count < count {
            set.insert(Int.random(in: min...max))
        }
        return Array(set)
    }

}



