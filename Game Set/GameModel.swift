//
//  GameSet.swift
//  Game
//
//  Created by Егор Пехота on 15.04.2021.
//

import Foundation

struct GameSet {

    var cards = Array<Card>()
    private let numberOfShapes = 3
    private let numberOfCardsAtStart = 12
    
    private var selectedCardsIndices: [Int] {
        get {
            cards.indices.filter { index in
                cards[index].isSelected
            }
        }
    }

    private var readyToPlayCardsIndices: [Int] {
        get {
            cards.indices.filter { index in
                !cards[index].onTable && !cards[index].inSet
            }
        }
    }
    
    init() {
        for shape in ShapeType.allCases {
            for shading in ShapeShading.allCases {
                for color in ShapeColor.allCases {
                    for numberOfShapes in 1...numberOfShapes {
                        cards.append(Card(id: cards.count, numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        cards.shuffle()
        for index in 0..<numberOfCardsAtStart {
            cards[index].onTable = true
        }
    }
    
    
    mutating func isSet(of indices:[Int]) {
        if ((cards[indices[0]].numberOfShapes == cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes == cards[indices[2]].numberOfShapes) || (cards[indices[0]].numberOfShapes != cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes != cards[indices[2]].numberOfShapes && cards[indices[0]].numberOfShapes != cards[indices[2]].numberOfShapes))
            && ((cards[indices[0]].shape == cards[indices[1]].shape && cards[indices[1]].shape == cards[indices[2]].shape) || (cards[indices[0]].shape != cards[indices[1]].shape && cards[indices[1]].shape != cards[indices[2]].shape && cards[indices[0]].shape != cards[indices[2]].shape))
            && ((cards[indices[0]].shading == cards[indices[1]].shading && cards[indices[1]].shading == cards[indices[2]].shading) || (cards[indices[0]].shading != cards[indices[1]].shading && cards[indices[1]].shading != cards[indices[2]].shading && cards[indices[0]].shading != cards[indices[2]].shading))
            && ((cards[indices[0]].color == cards[indices[1]].color && cards[indices[1]].color == cards[indices[2]].color) || (cards[indices[0]].color != cards[indices[1]].color && cards[indices[1]].color != cards[indices[2]].color && cards[indices[0]].color != cards[indices[2]].color))
            {
                cards[indices[0]].inSet = true
                cards[indices[1]].inSet = true
                cards[indices[2]].inSet = true
            }
    }
    
    //Selects or deselects card. Deselects cards if user selects 4-th card. Checks for set if there are three selected cards.
    mutating func select(card: Card) {
        if let firstIndex = cards.firstIndex(of: card) {
            if selectedCardsIndices.count == 3 {
                for index in selectedCardsIndices {
                    cards[index].isSelected = false
                }
            }
            cards[firstIndex].isSelected = !cards[firstIndex].isSelected
            if selectedCardsIndices.count == 3 {
                isSet(of: selectedCardsIndices)
            }
        }
    }
    
    mutating func addCards() {
        if selectedCardsIndices.count == 3 {
            for index in selectedCardsIndices {
                if cards[index].inSet {
                    cards[index].onTable = false
                }
            }
        }
        if !readyToPlayCardsIndices.isEmpty {
            let readyToPlay = readyToPlayCardsIndices[0..<3]
            readyToPlay.forEach { index in
                cards[index].onTable = true
            }
        }
    }
}

struct Card: Identifiable, Equatable {
    var id: Int
    var onTable: Bool = false {
        willSet {
            if newValue == false {
                self.isSelected = false
            }
        }
    }
    var isSelected: Bool = false
    var inSet: Bool = false
    
    let numberOfShapes: Int
    let shape: ShapeType
    let shading: ShapeShading
    let color: ShapeColor
}

enum ShapeType: CaseIterable {
    case diamond, squiggle, oval
}

enum ShapeShading: CaseIterable {
    case solid, stripped, open
}

enum ShapeColor: String, CaseIterable {
    case red, green, purple
}
