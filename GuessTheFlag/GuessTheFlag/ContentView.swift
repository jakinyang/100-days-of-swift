//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jae Chun Yang on 2024-11-18.
//

import SwiftUI
struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.blue)
            .padding()
        
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore: Int = 0
    @State private var endGame: Bool = false
    @State private var alertButtonLabel: String = "Continue"
    @State private var alertButtonMessage: String = ""
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
        }
        
        if userScore >= 8 {
            scoreTitle = "You won!"
            endGame.toggle()
            alertButtonLabel = "Play Again"
        }
        
        if userScore <= 0 {
            scoreTitle = "You lost!"
            endGame.toggle()
            alertButtonLabel = "Play Again"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if endGame == true {
            userScore = 0
            endGame.toggle()
        } else {
            alertButtonLabel = "Continue"
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .titleStyle()
                VStack(spacing: 15) {
                    VStack {
                        Text("What is the flag of")
                            .foregroundStyle(.white)
                            .font(.headline.weight(.medium))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button(alertButtonLabel, action: askQuestion)
                        } message: {
                            Text(alertButtonMessage)
                        }
                        .padding(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
    }

}

#Preview {
    ContentView()
}
