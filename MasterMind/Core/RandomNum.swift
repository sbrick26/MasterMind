//
//  RandomNum.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/2/22.
//

import Foundation
import UIKit


struct Answer {
    static var answer = ["0", "1", "2", "3"]
}

let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=4&base=10&format=plain&rnd=new")

class RandomNumber {
    
    
    class func getData() async throws -> [String] {
        
        let (data, response) = try await URLSession.shared.data(from: url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("HTTP ERROR")
            return ["0", "1", "2", "3"]
        }
        
        guard let strData = String(data: data, encoding: .utf8) else {
            print("COULNDT GET PROPER INPUT")
            return ["0", "1", "2", "3"]
        }
        
        let cleanData = Array(strData.filter {!$0.isWhitespace}).map { String($0) }
        Answer.answer = cleanData
        print(Answer.answer)
        return Answer.answer
    }
    
    
    class func fetchData() {
        
        let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=4&base=10&format=plain&rnd=new")
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print("there is error")
                Answer.answer = ["0", "1", "2", "3"]
            }
            else {
                if data != nil {
                    let strData = String(data: data!, encoding: .utf8)!
                    let cleanData = Array(strData.filter {!$0.isWhitespace}).map { String($0) }
                    Answer.answer = cleanData
                    //randomNum.self = cleanData
                }
            }
        }
        
        // Actually starts the task
        task.resume()
    }
}
