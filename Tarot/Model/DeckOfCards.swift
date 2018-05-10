//
//  DeckOfCards.swift
//  Tarot
//
//  Created by Rodney Cocker on 17/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation

struct DeckOfCards
{
    var deckOfCards:[MajorArcanaCard]
    var tabledCards:[MajorArcanaCard]
    
    init()
    {
        deckOfCards = MajorArcanaCard.getDeck()
        tabledCards = [MajorArcanaCard]()
    }
    
    func getCardDictionary() -> [String: MajorArcanaCard]
    {
        return MajorArcanaCard.getCardDictionary()
    }
    
    mutating func putCardsBackInDeck()
    {
        for card in 0..<tabledCards.count
        {
            let card = tabledCards.remove(at: card)
            let randomCardIndex = Int(arc4random_uniform(UInt32(deckOfCards.count)))
            deckOfCards.insert(card, at: randomCardIndex)
        }
    }
    
    mutating func shuffle()
    {
        for currentCardIndex in 0..<deckOfCards.count
        {
            let randomCardIndex = Int(arc4random_uniform(UInt32(deckOfCards.count)))
            
            if randomCardIndex != currentCardIndex{
                deckOfCards.swapAt(currentCardIndex, randomCardIndex)
            }
        }
    }
    
    mutating func tableACard()
    {
        let card = deckOfCards.remove(at: 0)
        tabledCards.append(card)
    }
    
    
}
