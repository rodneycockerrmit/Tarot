//
//  Model.swift
//  Tarot
//
//  Created by Rodney Cocker on 4/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation

class Model
{
    var answers:[String] = ["Go forth with faith",
                            "Magic is on your side",
                            "Plant the seed and it will grow",
                            "Another item"]
    
    init()
    {
        answers.append("Look to the stars to find your answer")
        
        answers += ["But dad, don't we eat the antelope"]
        
        answers.insert("You can't do this alone", at: 3)
        
        answers.remove(at: 4)
        
        answers.removeLast()
        
        print(answers)
        
        print(respond())
    }
    
    func respond() -> String
    {
        let response = Int(arc4random_uniform(UInt32(answers.count)))
        return answers[response]
    }
    
}
