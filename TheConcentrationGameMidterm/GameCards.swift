//
//  GameCards.swift
//  TheConcentrationGameMidterm
//
//  Created by Dinmukhamet Igissinov on 11/8/20.
//

import Foundation

class GameCards {
    let cards: [EmojiButton]
    
    init(cards: [EmojiButton]) {
        self.cards = cards.shuffled()
    }
}
