import Cocoa

func greet(message: String) -> Void {
    print(message)
}
func greetingMessage(name: String) -> Void {
    greet(message: "Hello")
    greet(message: "Welcome to the spa \(name)!")
}
greetingMessage(name: "Jessye")

let messages = ["Oi!", "Pssst!", "Hey!", "Over Here!"]

func giveMeRandomMessage(messages: [String]) -> String {
    messages.randomElement() ?? "What?"
}
giveMeRandomMessage(messages: messages)

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

var result = rollDice();
print(result)

func rollDiceConfig(limit: Int) -> Int {
    return Int.random(in: 1...limit)
}

let otherResult = rollDiceConfig(limit: 20)

print(otherResult)

func compareWords(first: String, second: String) -> Bool {
     return first.sorted() == second.sorted()
}

compareWords(first: "bool", second: "loob")

func getUsers(database: [String]) -> [String] {
    var names: [String] = []
    for name in database {
        names.append(name)
    }
    return names
}

