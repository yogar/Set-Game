//
//  GameView.swift
//
//  Created by Егор Пехота on 15.04.2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    @State private var showCards = false
    
    var cardsOnTable:[Card] {
        viewModel.cards.filter {
            card in (card.onTable && showCards)
        }
    }

    var body: some View {
        VStack() {
            HStack() {
                Button("New Game") {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        viewModel.startGame()
                    }
                }
                Spacer()
                Button("Add Cards") {
                    withAnimation(.spring()) {
                        viewModel.addCards()
                    }
                }
            }
            Grid(cardsOnTable) {card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.select(card: card)
                    }
                    .transition(.offset(x: CGFloat.random(in: -2000...2000), y: CGFloat.random(in: -2000...2000)))
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    showCards = true
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
                    .stroke(card.isSelected ? Color.black : Color.gray , lineWidth: 2)
                    .opacity(card.isSelected ? 0.8 : 0.5)
                VStack {
                    ForEach(0..<card.numberOfShapes, id: \.self) {_ in
                        switch card.shape {
                        case .oval: Ellipse()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Ellipse().fill(isSolid || isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*shapeSizeMultiplier)
                        case .diamond: Diamond()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Diamond().fill(isSolid || isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*shapeSizeMultiplier)
                        case .squiggle: Rectangle()
                            .strokeBorder(isOpen ? Color(card.color.rawValue) : Color.clear, lineWidth: 2)
                            .background(Rectangle().fill(isSolid || isStripped ? Color(card.color.rawValue) : Color.clear))
                            .opacity(isStripped ? 0.5 : 1)
                            .frame(height: geometry.size.height*shapeSizeMultiplier)
                        }
                    }
                }
                .padding([.trailing,.leading],(geometry.size.width-3*shapeSizeMultiplier)*shapeSizeMultiplier)
            }
            .aspectRatio(2/3, contentMode: .fit)
            .padding(4)
            .rotationEffect(Angle.degrees(card.setStatus == .set ? 5 : 0))
            .rotationEffect(Angle.degrees(card.setStatus == .notSet ? Double.random(in:(-5...0)) : 0))
        }
    }
    
    // MARK: - Visual Constants
    let shapeSizeMultiplier: CGFloat = 0.15
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(id: 2, numberOfShapes: 3, shape: .oval, shading: .stripped, color: .red))
    }
}
