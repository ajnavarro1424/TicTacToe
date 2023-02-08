//
//  ContentView.swift
//  TicTacToe
//
//  Created by Alex Navarro on 2/8/23.
//

import SwiftUI

struct ContentView: View {

    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumanTurn = true

    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                            GridItem(.flexible())]

    var body: some View {
        // Gives us the relative screen size of the device
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { index in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                            Image(systemName: moves[index]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)

                        }
                        .onTapGesture {
                            guard isSpaceOccupied(in: moves, forIndex: index) == false else {
                                return
                            }
                            moves[index] = Move(player: isHumanTurn ? .human : .ai, boardIndex: index)
                            isHumanTurn.toggle()


                        }
                    }
                }
                Spacer()
            }
            .padding()
        }

    }

    func isSpaceOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains { $0?.boardIndex == index }
    }
}

enum Player {
    case human, ai
}

struct Move  {
    let player: Player
    let boardIndex: Int

    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
