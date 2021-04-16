//
//  Game Set.swift
//  Game Set
//
//  Created by Егор Пехота on 15.04.2021.
//

import Foundation

struct GameSet {
    var cards = Array<Card>()
    
    let shapes = ["diamond","squiggle","oval"]
    let shadings = ["solid","striped","open"]
    let colors = ["red","green","purple"]
    
    init() {
        var id = 0
        for shape in shapes {
            for shading in shadings {
                for color in colors {
                    for numberOfShapes in 1...3 {
                        cards.append(Card(id: id, numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color))
                        id += 1
                    }
                }
            }
        }
    }
}

struct Card {
    var id: Int
    let numberOfShapes: Int
    let shape: String
    let shading: String
    let color: String
}
