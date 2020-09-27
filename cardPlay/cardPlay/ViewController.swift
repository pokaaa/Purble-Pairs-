//
//  ViewController.swift
//  cardPlay
//
//  Created by Apple08 on 2020/9/14.
//  Copyright © 2020 Apple08. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0
    {
        
        didSet{
            flipCountLabel.text = "Flips Count:\(flipCount)"
            
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosed card is not in cardButtons")
        }
        flipCountLabel.text = "Flips Count: \(flipCount)"
    }
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card),for: .normal)
                button.backgroundColor = _ColorLiteralType(red: 1, green: 1, blue: 1,alpha: 1)
            }else{
                button.setTitle("", for: .normal)
                if card.isMatched{
                    button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        //_ColorLiteralType(red: 1, green:0, blue: 0, alpha: 0)
                }else{
                    
                    button.backgroundColor = #colorLiteral(red: 0.6416720384, green: 0.1243589849, blue: 1, alpha: 1)
                    
                        //_ColorLiteralType(red: 1,green: 0, blue: 0, alpha: 1)
                }
            }
            
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
  

    var emojiChoices = ["🧜🏻‍♀️","🦹🏼‍♂️","💃🏻","🧝🏻‍♀️"]
    var emoji = [Int : String]()
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil && emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    func flipCard(withEmoji emoji : String, on button : UIButton){
        if(button.currentTitle == emoji){
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.purple
        }else{
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
    }
}

