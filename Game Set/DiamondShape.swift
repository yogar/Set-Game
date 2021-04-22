//
//  DiamondShape.swift
//  Game Set
//
//  Created by Егор Пехота on 20.04.2021.
//

import SwiftUI

struct Diamond: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let width = rect.width - insetAmount
        let height = rect.height - insetAmount
        let start = CGPoint(x: width / 2, y: 0.0)
        p.move(to: start)
        p.addLine(to: CGPoint(x: width, y: height / 2))
        p.addLine(to: CGPoint(x: width / 2, y: height))
        p.addLine(to: CGPoint(x:0, y: height/2))
        p.addLine(to: start)
        return p
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var path = self
        path.insetAmount += amount
        return path
    }
}
