//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Oliver Hu on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var computerSelection = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var currentScore = 0
    @State private var questionCount = 1
    @State private var maxQuestions = false
    let moves = ["rock", "paper", "scissors"]
    let emojis = ["✊", "✋", "✌️"]
    
    var winMove: Int {
        switch moves[computerSelection] {
        case "rock":
            return 1
        case "paper":
            return 2
        default:
            return 0
        }
    }
    
    var loseMove: Int {
        switch moves[computerSelection] {
        case "rock":
            return 2
        case "paper":
            return 0
        default:
            return 1
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                Text("Your score is \(currentScore)")
                Text("Computer selected \(emojis[computerSelection])")
                    .font(.largeTitle)
                Text("Tap the move to")
                Text(shouldWin ? "win" : "lose")
                    .font(.title.bold())
            }
            
            ForEach(0..<3) { number in
                Button {
                    userTapped(number)
                } label: {
                    Text(emojis[number])
                        .font(.system(size: 100))
                }
            }
        }
        .alert(Text("Game over"), isPresented: $maxQuestions) {
            Button("Press to reset game", action: reset)
        } message: {
            Text("Your final score is \(currentScore)")
        }
    }
    
    
    func userTapped(_ number: Int) {
        if shouldWin {
            if number == winMove {
                currentScore += 1
            } else if number == loseMove {
                currentScore -= 1
            }
            
        } else {
            if number == loseMove {
                currentScore += 1
            } else if number == winMove {
                currentScore -= 1
            }
        }
        
        questionCount += 1
        computerSelection = Int.random(in: 0...2)
        shouldWin.toggle()
        if questionCount > 10 {
            maxQuestions = true
        }
    }
    
    func reset() {
        currentScore = 0
        questionCount = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
