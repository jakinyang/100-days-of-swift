import Cocoa
var thing: String = "Hello, Swift!"
let that: String = "Hello, World!"
thing = "Hello, you!"
print(thing)
var greeting = "Hello, playground"

var firstPlayerName = "John Wick"
var players: [String] = ["John", "Helen", "Steve", "Joey"]
print(players.count)

let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
days[1].hasSuffix("day")

var currentScore: Int = 20
currentScore += 4
print(currentScore)
var massiveNumber: Int = 20_000_000_000
massiveNumber.isMultiple(of: 2)
print(massiveNumber)
var name = "Ted"
print(name)
name = "Rebekka"
print(name)
name = "Ken"
print(name)

let character = "Dolly"
print(character)

var player = "Joe"
print(player)
player = "Crump"
print(player)

var cookie: String
cookie = "ChocolateChip"

let furniture: String
furniture = "Chair"

furniture.count

let actor = "Me"
let filenme = "montreal.jpg"
let result = "yay"

let quote = "I \"Believe\""
let movie = """
I am a moo
A little moo
"""

let nameLength = actor.count
print(nameLength)
print(result.uppercased())
print(movie.hasPrefix("I am"))
print(filenme.hasSuffix(".jpg"))

let score = 10
let bignum = 100_000_000_000_000


let lowerscore = score - 2
let higherscore = score + 10
let doubleScore = score * 2
let halfScore = score / 2

var counter = 0
counter += 5
counter -= 2
counter *= 3
counter /= 2

let int: Int = 1
let double: Double = 0.00001 + 2.003002 + Double(int)
