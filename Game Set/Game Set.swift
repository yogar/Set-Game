//
//  Game Set.swift
//  Game Set
//
//  Created by Егор Пехота on 15.04.2021.
//

import Foundation

struct GameSet {
    var cards = Array<Card>()
    
    let shapes = ("diamond","squiggle","oval")
    let shadings = ("solid","striped","open")
    let colors = ("red","green","purple")
}

struct Card {
    var id: Int
    var numberOfShapes: Int
    var shape: String
    var shading: String
    var color: String
}
