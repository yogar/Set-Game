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

struct CardView: View {
    var card: Card
    var body: some View {
        ZStack {
            if card.isSelected {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, lineWidth: 3)
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
            VStack {
                ForEach(0..<card.numberOfShapes) {_ in
                    switch card.shape {
                    case "oval": Ellipse()
                    case "diamond": Capsule()
                    case "squiggle": Circle()
                    default: EmptyView()
                    }
                }
            }
            .foregroundColor(Color(card.color))
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
