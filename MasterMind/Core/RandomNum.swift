//
//  RandomNum.swift
//  MasterMind
//
//  Created by Swayam Barik on 5/2/22.
//

import Foundation
import UIKit

// struct to hold secret code to access in other View Controller
struct Answer {
    static var answer = ["0", "1", "2", "3"]
}

// url of random API to get 4 numbers from 0 to 7
let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=4&base=10&format=plain&rnd=new")

class RandomNumber {
    // async function to get random numbers from API
    class func getData() async throws -> [String] {
        
        // connect to URL Session
        let (data, response) = try await URLSession.shared.data(from: url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            //if reponse error
            print("HTTP ERROR")
            return ["0", "1", "2", "3"]
        }
        // convert data from request to String data
        guard let strData = String(data: data, encoding: .utf8) else {
            //if we can't get proper data
            print("COULNDT GET PROPER INPUT")
            return ["0", "1", "2", "3"]
        }
        // array clean up from API call
        let cleanData = Array(strData.filter {!$0.isWhitespace}).map { String($0) }
        Answer.answer = cleanData
        print(Answer.answer)
        return Answer.answer
    }
    
    // old way of calling with closure
    /*class func fetchData() {
        
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
    } */
}
