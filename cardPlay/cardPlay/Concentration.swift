//
//  Concentration.swift
//  cardPlay
//
//  Created by 鲁大侠 on 2020/9/17.
//  Copyright © 2020 Apple08. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    init(numberOfPairsOfCards : Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card , card]
        }
        for _ in cards.indices{
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            let card = cards.remove(at: index)
            cards.append(card)
        }
    }
   /* func chooseCard(at index : Int){
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        }else{
            cards[index].isFaceUp = true
        }
    }*/
    var indexofOneAndOnlyFaceUpCard : Int?
    func chooseCard(at index : Int){
        if(!cards[index].isMatched){
            if let matchIndex = indexofOneAndOnlyFaceUpCard , matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = nil
            }else{//either no cards or 2 cards are faced up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = index
            }
        }
    }
}

struct Card
{
    var identifier : Int
    var isFaceUp = false
    var isMatched = false
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
