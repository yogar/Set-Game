//
//  GameView.swift
//
//  Created by Егор Пехота on 15.04.2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    let columns: [GridItem] = Array(repeating: GridItem.init(.flexible()), count: 3)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.cards) {card in
                    if card.onTable {
                        CardView(card: card)
                            .onTapGesture {
                                viewModel.select(card: card)
                            }
                    }
                }
            }
        }
    }
}

struct CardView: View {
    var card: Card
    var isStripped: Bool {
        card.shading == .stripped ? true : false
    }
    var isSolid: Bool {
        card.shading == .solid ? true : false
    }
    var isOpen: Bool {
        card.shading == .open ? true : false
    }
    var body: some View {
        ZStack {
            if card.isSelected {
                RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 3)
            } else {
                RoundedRectangle(cornerRadius: 10)
                .stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
            VStack {
                ForEach(0..<card.numberOfShapes) {_ in
                    switch card.shape {
                    case .oval: Ellipse()
                    case .diamond: Diamond().stroke(lineWidth: 2).background(Diamond().fill(isSolid ? Color(card.color.rawValue) : Color.clear))
                    case .squiggle: Rectangle().strokeBorder(Color(card.color.rawValue), lineWidth: 2).background(Rectangle().fill(isSolid ? Color(card.color.rawValue) : Color.clear))
                    }
                }
                Ellipse().stroke().fill()
                Text(String(card.id))
            }
//            .opacity(isStripped ? 0.7 : 1)
//            .foregroundColor(isSolid ? Color(card.color.rawValue) : Color.clear)
            .padding()
        }
        .aspectRatio(2/3,contentMode: .fit)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
