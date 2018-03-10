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
    let majorArcanaCards:[String: MajorArcanaCard]
    var currentCard:MajorArcanaCard = MajorArcanaCard.fool
    
    init(){
        majorArcanaCards = MajorArcanaCard.createDeck()
    }

    func respond() -> String
    {
        let response = Int(arc4random_uniform(UInt32(majorArcanaCards.count)))

        currentCard = Array(majorArcanaCards.values)[response]
        
        return currentCard.interpretation
    }
}
