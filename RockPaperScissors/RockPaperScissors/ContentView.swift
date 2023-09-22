//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jae Chun Yang on 2023-09-06.
//

import SwiftUI

struct Title: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.custom("HeadTitle", size: 58).weight(.black))
            .foregroundColor(.primary)
    }
}

struct MainText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.primary)
    }
}

struct Subtitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title2.weight(.bold))
            .foregroundColor(.primary)
    }
}


struct ContentView: View {
    @State private var choices: [String] = ["rock", "paper", "scissors"]
    @State private var steps: [String] = ["PLAY!", "ROCK!", "PAPER!", "SCISSORS!"]
    @State private var computerChoice: Int = Int.random(in: 0...2)
    @State private var playerChoice: Int = 0
    @State private var showingResult: Bool = false
    @State private var showingComputerChoice: Bool = false
    @State private var resultTitle: String = ""
    @State private var step: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .mint, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Title(text: "R.P.S")
                VStack {
                    HStack {
                        Spacer()
                        Subtitle(text: "You")
                        Spacer()
                        Spacer()
                        Subtitle(text: "Computer")
                        Spacer()
                        
                    }
                    .padding(16)
                    HStack {
                        Spacer()
                        Image("\(choices[playerChoice])_small")
                        Spacer()
                        Spacer()
                        Image(
                            showingComputerChoice ?
                            "\(choices[computerChoice])_small"
                            :
                                "question_mark"
                        )
                        Spacer()
                    }
                }
                Spacer()
                MainText(text: "Make your play!")
                HStack {
                    Button {
                        onSelect(0)
                    } label: {
                        Image("rock_small")
                    }
                    Button {
                        onSelect(1)
                    } label: {
                        Image("paper_small")
                    }
                    Button {
                        onSelect(2)
                    } label: {
                        Image("scissors_small")
                    }
                }
                Spacer()
                Button {
                    onPressPlay()
                } label: {
                    MainText(text: steps[step])
                }
                Spacer()
            }
            .padding()
            .alert(resultTitle, isPresented: $showingResult) {
                Button("Play Again", action: reset)
            } message: {
                Text("You played \(choices[playerChoice]) and the computer played \(choices[computerChoice])")
            }
        }
    }
    
    func getCorrectAnswer(choice: Int) -> Int {
        var correctAnswer: Int
        switch choice {
            case 0:  correctAnswer = 1
            case 1:  correctAnswer = 2
            default: correctAnswer = 0
        }
        return correctAnswer
    }
    
    func onSelect(_ number: Int) {
        playerChoice = number
    }
    
    func onPlay(_ number: Int) {
        if playerChoice == getCorrectAnswer(choice: computerChoice) {
            resultTitle = "You Win!"
        } else if playerChoice == computerChoice {
            resultTitle = "A Tie!"
        } else {
            resultTitle = "You Lose!"
        }
        showingResult = true
    }
    
    func onPressPlay() {
        if step == 3 {
            step = 0
        } else {
            step += 1
            if step == 3 {
                onPlay(playerChoice)
                showingComputerChoice = true
            }
        }
    }
    func reset() {
        computerChoice = Int.random(in: 0...2)
        showingComputerChoice = false
        step = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
