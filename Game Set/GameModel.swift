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

    var readyToPlayCardsIndices: [Int] {
        get {
            cards.indices.filter { index in
                !cards[index].onTable && !(cards[index].setStatus == .set)
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
    
    
    private func isSet(of indices:[Int]) -> Bool {
        if ((cards[indices[0]].numberOfShapes == cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes == cards[indices[2]].numberOfShapes) || (cards[indices[0]].numberOfShapes != cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes != cards[indices[2]].numberOfShapes && cards[indices[0]].numberOfShapes != cards[indices[2]].numberOfShapes))
            && ((cards[indices[0]].shape == cards[indices[1]].shape && cards[indices[1]].shape == cards[indices[2]].shape) || (cards[indices[0]].shape != cards[indices[1]].shape && cards[indices[1]].shape != cards[indices[2]].shape && cards[indices[0]].shape != cards[indices[2]].shape))
            && ((cards[indices[0]].shading == cards[indices[1]].shading && cards[indices[1]].shading == cards[indices[2]].shading) || (cards[indices[0]].shading != cards[indices[1]].shading && cards[indices[1]].shading != cards[indices[2]].shading && cards[indices[0]].shading != cards[indices[2]].shading))
            && ((cards[indices[0]].color == cards[indices[1]].color && cards[indices[1]].color == cards[indices[2]].color) || (cards[indices[0]].color != cards[indices[1]].color && cards[indices[1]].color != cards[indices[2]].color && cards[indices[0]].color != cards[indices[2]].color))
            {
                return true
            }
        else {
            return false
        }
    }
    
    //Selects or deselects card. Deselects cards if user selects 4-th card. Checks for set if there are 3 selected cards.
    mutating func select(card: Card) {
        for index in selectedCardsIndices {
            if cards[index].setStatus == .notSet {
                cards[index].setStatus = .unknown
            }
        }
        let firstIndex = cards.firstIndex(of: card)!
        if selectedCardsIndices.count == 3 {
            for index in selectedCardsIndices {
                cards[index].isSelected = false
                if cards[index].setStatus == .set {
                    cards[index].onTable = false
                }
            }
        }
        cards[firstIndex].isSelected = !cards[firstIndex].isSelected
        if selectedCardsIndices.count == 3 {
            if isSet(of: selectedCardsIndices) {
                for index in selectedCardsIndices {
                    cards[index].setStatus = .set
                }
            } else {
                for index in selectedCardsIndices {
                    cards[index].setStatus = .notSet
                }
            }
        }
    }
    
    mutating func addCards() {
        if selectedCardsIndices.count == 3 {
            for index in selectedCardsIndices {
                if cards[index].setStatus == .set {
                    cards[index].onTable = false
                }
            }
        }
        if !readyToPlayCardsIndices.isEmpty {
            for index in readyToPlayCardsIndices[0..<3] {
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
    var setStatus: SetStatus = .unknown
    
    let numberOfShapes: Int
    let shape: ShapeType
    let shading: ShapeShading
    let color: ShapeColor
}

enum SetStatus {
    case unknown, set, notSet
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
