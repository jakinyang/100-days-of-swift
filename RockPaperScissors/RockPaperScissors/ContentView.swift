import SwiftUI

enum RPS: String {
    case rock, paper, scissors
    
    var displayName: String {
        self.rawValue.capitalized
    }
}

enum Results: String {
    case draw, computerWin, playerWin
    
    var message: String {
        switch self {
        case .draw:
            return "It's a draw!"
        case .computerWin:
            return "You lost!"
        case .playerWin:
            return "You won!"
        }
    }
}

func determineWinner(computerChoice: RPS, playerChoice: RPS) -> Results {
    if computerChoice == playerChoice { return .draw }
    
    switch computerChoice {
    case .rock:
        return playerChoice == .scissors ? .computerWin : .playerWin
    case .paper:
        return playerChoice == .rock ? .computerWin : .playerWin
    case .scissors:
        return playerChoice == .paper ? .computerWin : .playerWin
    }
}

let rpsChoices: [RPS] = [.rock, .paper, .scissors]

func getComputerChoice() -> RPS {
    rpsChoices[Int.random(in: 0..<rpsChoices.count)]
}

struct RPSButtonLabel: View {
    var name: String
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(24)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct SubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.medium)
    }
}

extension View {
    func subtitleStyle() -> some View {
        modifier(SubTitle())
    }
}

struct ContentView: View {
    @State private var computerChoice: RPS = getComputerChoice()
    @State private var currentRound: Int = 1
    @State private var playerScore: Int = 0
    @State private var computerScore: Int = 0
    @State private var isResultShowing: Bool = false
    @State private var resultAlertTitle: String = ""
    @State private var resultAlertMessage: String = ""

    private let totalRounds = 10

    var subtitleText: String {
        currentRound > totalRounds ? "Game Over!" : "Make your choice!"
    }

    private func resetGame() {
        currentRound = 1
        playerScore = 0
        computerScore = 0
    }

    func onNextPress() {
        isResultShowing = false
        
        if currentRound >= totalRounds {
            resultAlertTitle = playerScore > computerScore ? "You won!" :
                               playerScore < computerScore ? "You lost!" : "It's a draw!"
            resetGame()
        } else {
            currentRound += 1
            computerChoice = getComputerChoice()
        }
    }

    func onPlayerChoice(choice: RPS) {
        let result = determineWinner(computerChoice: computerChoice, playerChoice: choice)
        
        switch result {
        case .playerWin:
            playerScore += 1
        case .computerWin:
            computerScore += 1
        case .draw:
            break
        }
        
        resultAlertTitle = result.message
        resultAlertMessage = "You played \(choice.displayName). The computer played \(computerChoice.displayName)."
        isResultShowing = true
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 233 / 255, green: 255 / 255, blue: 112 / 255),
                    Color(red: 255 / 255, green: 214 / 255, blue: 112 / 255),
                    Color(red: 255 / 255, green: 151 / 255, blue: 112 / 255),
                    Color(red: 255 / 255, green: 112 / 255, blue: 166 / 255),
                    Color(red: 112 / 255, green: 214 / 255, blue: 255 / 255),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Text("Rock Paper Scissors")
                    .titleStyle()

                Text(subtitleText)
                    .subtitleStyle()

                ForEach(rpsChoices, id: \.self) { choice in
                    Button {
                        onPlayerChoice(choice: choice)
                    } label: {
                        RPSButtonLabel(name: choice.rawValue)
                    }
                    .alert(resultAlertTitle, isPresented: $isResultShowing) {
                        Button("Next Round", action: onNextPress)
                    } message: {
                        Text(resultAlertMessage)
                    }
                }

                HStack {
                    Spacer()
                    Text("Your score: \(playerScore)")
                        .font(.title3.weight(.medium))
                    Spacer()
                    Text("Computer score: \(computerScore)")
                        .font(.title3.weight(.medium))
                    Spacer()
                }
                .padding()

                Text("Round: \(currentRound) of \(totalRounds)")
                    .subtitleStyle()
            }
        }
    }
}

#Preview {
    ContentView()
}
