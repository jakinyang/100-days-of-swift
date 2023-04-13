import SwiftUI

class RockPaperScissorsGame: ObservableObject {
    @Published var playerWin: Bool = Bool.random()
    @Published var computerChoice: Int = Int.random(in: 0...2)
    @Published var score: Int = 0
    @Published var round: Int = 1
    @Published var gameOver: Bool = false
    
    let hands = ["Rock", "Paper", "Scissors"]
    
    func beginNextRound() {
        if round < 10 {
            round += 1
            computerChoice = Int.random(in: 0...2)
            playerWin.toggle()
        } else {
            gameOver = true
        }
    }
    
    func choiceSelected(_ hand: String) {
        let playerChoice = hand
        let matchUp = getMatchUp(playerChoice: playerChoice, computerChoice: hands[computerChoice])
        
        if playerWin == true {
            if matchUp == "Win" {
                score += 1
            }
        } else {
            if matchUp == "Lose" {
                score += 1
            }
        }
        beginNextRound()
    }
    
    private func getMatchUp(playerChoice: String, computerChoice: String) -> String {
        if playerChoice == computerChoice {
            return "Draw"
        }
        switch playerChoice {
        case "Rock":
            return computerChoice == "Paper" ? "Lose" : "Win"
        case "Paper":
            return computerChoice == "Scissors" ? "Lose" : "Win"
        case "Scissors":
            return computerChoice == "Rock" ? "Lose" : "Win"
        default:
            return "Error"
        }
    }
}

struct ContentView: View {
    @StateObject private var game = RockPaperScissorsGame()
    
    var body: some View {
        VStack {
            if game.gameOver {
                Text("Game Over!")
                    .font(.largeTitle)
                Text("Your score is \(game.score)")
            } else {
                VStack {
                    Text("Win or Lose Condition")
                    Text(game.playerWin ? "You must Win" : "You must lose")
                }
                .padding()
                VStack {
                    Text("Computer Choice")
                    Text(game.hands[game.computerChoice])
                        .textCase(.uppercase)
                }
                .padding()
                HStack {
                    ForEach(game.hands, id: \.self) { hand in
                        Button {
                            game.choiceSelected(hand)
                        } label: {
                            Text(hand)
                        }
                    }
                }
                .padding()
                Text("Round: \(game.round)")
                Text("Score: \(game.score)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
