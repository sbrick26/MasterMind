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
    
    let answer = ["0", "1", "2", "3"]
    var guessColors: [[UIColor?]] = Array(repeating: Array(repeating: UIColor.systemGray, count: 4), count: 10)
    private var guesses: [[String?]] = Array(repeating: Array(repeating: nil, count: 4), count: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray2
        addChildren()
    }

    private func addChildren() {
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
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey number: String) {
        print(number)
        
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
                        if number == answer[j] {
                            guessColors[i][j] = .systemRed
                        } else {
                            for x in 0..<answer.count {
                                if answer[x] == number {
                                    guessColors[i][j] = .systemMint
                                }
                            }
                        }
                        break
                    }
                    
                }
                if stop {
                    break
                }
            }
        }
        
        boardVC.reloadData()
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
            print(guessColors)
            return guessColors[indexPath.section][indexPath.row - 4]
            
        }
        
        return .systemGray
    }
    
}



