//
//  GameViewModel.swift
//
//  Created by Егор Пехота on 17.04.2021.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published private var model: GameSet

    init() {
        model = GameSet()
    }
    
    // MARK: - Intents
    
    var cards: Array<Card> {
        model.cards
    }
    
    var readyToPlayCardsCount: Int {
        model.readyToPlayCardsIndices.count
    }
    
    func select(card: Card) {
        model.select(card: card)
    }
    
    func startGame() {
        model = GameSet()
    }
    
    func addCards() {
        model.addCards()
    }
}
