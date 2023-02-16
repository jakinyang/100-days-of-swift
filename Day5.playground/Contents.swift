import Cocoa

var a: Bool = true
var b: Bool = false

if a == true && b == false {
    print("Condition met for a and b!")
}

if a {
    print("a is true")
} else if b {
    print("b is true")
} else if a && b {
    print("a and b are true")
} else {
    print("neither a nor b are true")
}

var score = 99

if score >= 100 {
    print("You win!")
} else {
    print("Score isn't 100 yet!")
}

var numbers: [Int] = [1, 2, 3, 4, 5]

numbers.append(6)

print(numbers)

if numbers.count > 5 {
    numbers.remove(at: 0)
}

print(numbers)

var username: String = "Taylor Swift"

if username.isEmpty == true {
    username = "Anonymous"
}

print(username)

// Switch Statement

enum weather {
    case sun, rain, wind, snow, unknown
}

var forecast: weather = .snow

switch forecast {
case .sun:
    print("Sunny!")
case .wind:
    print("Windy!")
case .rain:
    print("Rainy!")
case .snow:
    print("Snowy!")
case .unknown:
    print("Wot?")
default:
    print("What are you doing?!")
}

let age = 17
let citizen = true

// Ternary
var canVote: Bool = age >= 18 ? citizen ? true : false : false

print(canVote)
