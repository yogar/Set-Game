//
//  GameView.swift
//
//  Created by Егор Пехота on 15.04.2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 70, maximum: 110), spacing: 0)
    ]
    var body: some View {
        let cardsOnTable = viewModel.cards.filter {
            card in card.onTable
        }
        VStack(alignment: .leading) {
            Button("New Game") {
                withAnimation(.easeIn) {
                    viewModel.startGame()
                }
            }
            Grid(cardsOnTable) {card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.select(card: card)
                    }
            }
        }
        .padding()
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
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: card.isSelected ? 3 : 2)
                VStack {
                    ForEach(0..<card.numberOfShapes, id: \.self) {_ in
                        switch card.shape {
                        case .oval: Ellipse()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Ellipse().fill(isSolid ||  isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*0.2)
                        case .diamond: Diamond()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Diamond().fill(isSolid ||  isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*0.2)
                        case .squiggle: Rectangle()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Rectangle().fill(isSolid ||  isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*0.2)
                        }
                    }
                }
                .padding((geometry.size.height-0.6)*0.1)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .padding(4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewDevice("iPhone 11")
    }
}
