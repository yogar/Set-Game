//
//  GameSet.swift
//  Game
//
//  Created by Егор Пехота on 15.04.2021.
//

import Foundation

struct GameSet {
    var cards = Array<Card>()
    var countOfSelected: Int?
    {
        selectedCardsIndices?.count ?? nil
    }
    private var selectedCardsIndices: [Int]? {
        get {
            cards.indices.filter {
                index in cards[index].isSelected
            }
        }
    }

    
    let shapes = ["diamond","squiggle","oval"]
    let shadings = ["solid","striped","open"]
    let colors = ["red","green","purple"]
    let numberOfShapes = 3
    
    init() {
        for shape in shapes {
            for shading in shadings {
                for color in colors {
                    for numberOfShapes in 1...numberOfShapes {
                        cards.append(Card(id: cards.count, numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        cards.shuffle()
        for index in 0..<12 {
            cards[index].onTable = true
        }
    }
    
    mutating func isSet(of indices:[Int]) {
        print(indices)
        if cards[indices[0]].numberOfShapes == cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes == cards[indices[2]].numberOfShapes {
            cards[indices[0]].inSet = true
            cards[indices[1]].inSet = true
            cards[indices[2]].inSet = true
 
        } else
        if cards[indices[0]].numberOfShapes != cards[indices[1]].numberOfShapes && cards[indices[1]].numberOfShapes != cards[indices[2]].numberOfShapes && cards[indices[0]].numberOfShapes != cards[indices[2]].numberOfShapes {
            cards[indices[0]].inSet = true
            cards[indices[1]].inSet = true
            cards[indices[2]].inSet = true
        }
    }
    
    mutating func select(card: Card) {
        if let firstIndex = cards.firstIndex(of: card) {
            cards[firstIndex].isSelected = !cards[firstIndex].isSelected
            print(countOfSelected!)
            if countOfSelected == 3 {
                isSet(of: selectedCardsIndices!)
            }
        }
    }
}

struct Card: Identifiable, Equatable {
    var id: Int
    var onTable: Bool = false
    var isSelected: Bool = false
    var inSet: Bool = false {
        didSet {
            onTable = false
            isSelected = false
        }
    }
    let numberOfShapes: Int
    let shape: String
    let shading: String
    let color: String
}
