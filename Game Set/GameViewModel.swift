//
//  GameViewModel.swift
//
//  Created by Егор Пехота on 17.04.2021.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var model: GameSet

    init() {
        model = GameSet()
    }
    
    // MARK: - Intents
    
    var cards: Array<Card> {
        model.cards
    }
    
    
    func select(card: Card) {
        model.select(card: card)
    }
}
