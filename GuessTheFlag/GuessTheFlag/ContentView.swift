//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jae Chun Yang on 2023-04-08.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.black))
            .foregroundColor(.white)
            .padding()
    }
}

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var selectedCorrectFlag: Bool?
    @State private var gameOver: Bool = false
    @State private var currentScore: Int = 0
    @State private var round: Int = 0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        round += 1
        if round == 7 {
            gameOver = true
            return
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        currentScore = 0
        round = 0
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack (spacing: 30) {
                Text("Guess the Flag")
                    .modifier(Title())
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.headline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        FlagImage(image: countries[number])
                    }
                }
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.weight(.semibold))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Play Again?", action: reset)
        } message: {
            Text("Your final score is \(currentScore)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
