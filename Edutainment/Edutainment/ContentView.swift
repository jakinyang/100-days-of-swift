//
//  ContentView.swift
//  Edutainment
//
//  Created by Jae Chun Yang on 2025-01-05.
//

// Your goal is to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on.

// Core Features
// 1. Which multiplication table (2 through 12)
// 2. How many questions in that mult table (1 through 20)
// 3. Score count

// Core Implementation Components
// 1. State for which multiplication table
// 2. State for how many questions
// 3. State to keep track of score (number of questions answered right)
// 4. Function takes state 1 and state 2 and then outputs an array of questions: f(Int, Int) -> [String] { ... }
// 5. Some kind of evaluation function that takes in answer input, actual answer and puts out if it's correct or not: f(Int, Int) -> Bool { ... }
// 6. State for current question
// 7. State for array of questions
// 8. State to keep track of which phase game is in

// Game Flow
// 1. Input Phase
//      a. Input mult
//      b. Input number of questions
//      c. Press start
// 2. Play Phase
//      a. A question is answered by inputing some Int
//      b. Press enter
//      c. Pressing enter runs evaluation function
//          - Evaluation function needs to do multiple things
//          - Evaluate response to the answer
//          - Update score state if appropriate
//          - Increment Question
//          - Determine game state - is the game over, should move onto Result Phase, etc.
//      d. Depending on result of eval function, update score state, present new question
// 3. Result Phase
//      a. Show final score
//      b. Show button to restart game (return to input phase)

import SwiftUI

struct ContentView: View {
    
    // Game states
    enum GameMode {
        case input, game, result
    }
    
    // State variables
    @State private var score: Int = 0
    @State private var gameMode: GameMode = .input
    @State private var timesTable: Int = 2
    @State private var numberOfQuestions: Int = 5
    @State private var currentQuestion: Int = 0
    @State private var questions: [(String, Int)] = []
    @State private var userAnswer: String = ""
    @State private var isShowingResult: Bool = false
    @State private var roundResult: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                switch gameMode {
                case .input:
                    inputView()
                case .game:
                    gameView()
                case .result:
                    resultView()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("TimesTabler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    gameButton()
                }
            }
        }
    }
    
    // MARK: - UI Views
    
    private func inputView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Choose Multiplication Table").font(.headline)
            Stepper(value: $timesTable, in: 2...12) {
                Text("Table: \(timesTable)")
            }
            
            Text("Choose Number of Questions").font(.headline)
            Stepper(value: $numberOfQuestions, in: 1...20) {
                Text("\(numberOfQuestions) Questions")
            }
        }
    }
    
    private func gameView() -> some View {
        VStack(spacing: 20) {
            Text("Score: \(score)")
                .font(.headline)
            
            Text("Question \(currentQuestion + 1) of \(questions.count)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(questions[currentQuestion].0)
                .font(.title)
                .multilineTextAlignment(.center)
            
            TextField("Your Answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .border(.gray)
                .multilineTextAlignment(.center)
                .frame(width: 200)
            
            Spacer()
        }
        .alert(isPresented: $isShowingResult) {
            Alert(
                title: Text(roundResult ? "Correct!" : "Incorrect"),
                message: Text(roundResult ? "Nice job!" : "The answer was \(questions[currentQuestion].1)."),
                dismissButton: .default(Text(currentQuestion == questions.count - 1 ? "See Results" : "Next")) {
                    nextQuestion()
                }
            )
        }
    }
    
    private func resultView() -> some View {
        VStack(spacing: 20) {
            Text("Game Over!")
                .font(.largeTitle)
                .bold()
            
            Text("Final Score: \(score) / \(questions.count)")
                .font(.title)
        }
    }
    
    private func gameButton() -> some View {
        Button(action: {
            switch gameMode {
            case .input:
                startGame()
            case .game:
                checkAnswer()
            case .result:
                resetGame()
            }
        }) {
            Text(gameMode == .input ? "Start" : gameMode == .game ? "Submit" : "Play Again")
        }
        .disabled((gameMode == .input && (timesTable < 2 || timesTable > 12 || numberOfQuestions < 1 || numberOfQuestions > 20)) ||
                  (gameMode == .game && userAnswer.isEmpty))
    }
    
    // MARK: - Game Logic
    
    private func generateTimesTableQuestions(timesTable: Int, numberOfQuestions: Int) -> [(String, Int)] {
        let allQuestions = (1...12).map { ("\(timesTable) × \($0) = ?", timesTable * $0) }
        return Array(allQuestions.shuffled().prefix(numberOfQuestions))
    }
    
    private func evaluateAnswer(userAnswer: Int, actualAnswer: Int) -> Bool {
        return userAnswer == actualAnswer
    }
    
    private func startGame() {
        questions = generateTimesTableQuestions(timesTable: timesTable, numberOfQuestions: numberOfQuestions)
        currentQuestion = 0
        score = 0
        gameMode = .game
    }
    
    private func checkAnswer() {
        let correctAnswer = questions[currentQuestion].1
        roundResult = evaluateAnswer(userAnswer: Int(userAnswer) ?? -1, actualAnswer: correctAnswer)
        if roundResult { score += 1 }
        isShowingResult = true
    }
    
    private func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
            userAnswer = ""
        } else {
            gameMode = .result
        }
    }
    
    private func resetGame() {
        timesTable = 2
        numberOfQuestions = 5
        score = 0
        currentQuestion = 0
        userAnswer = ""
        gameMode = .input
    }
}

#Preview {
    ContentView()
}
