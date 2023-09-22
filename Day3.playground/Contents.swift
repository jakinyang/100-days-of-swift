import Cocoa

// Arrays
var beetles = ["John", "Paul", "George", "Ringo"]
let numbers = [1, 2, 3, 4, 5, 6]
var temperatures = [1.1, 2.3, 4.5]

beetles.append("Adrian")

var scores = Array<Int>()
scores.append(100)
scores.append(20)
scores.append(39)

scores

var albums = Array<String>()

albums.append("Folklore")
albums.append("Fearless")
albums.append("1989")

print(albums.count)

albums.remove(at: 2)

print(albums)

print(albums.contains("Fearless"))

let reversedNumbers = numbers.reversed()
print(reversedNumbers)
print(numbers)

scores.sort()

// Dictionaries
let singer = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(singer["name", default: "Unknown"])
print(singer["job", default: "Unknown"])
print(singer["location", default: "Unknown"])
print(singer["manager", default: "Unknown"])

var heights = [String: Int]()
heights["Jae"] = 178

// Set
let people = Set(["John", "Paul", "George", "Ringo", "Phil"])

var raccoonMoos = Set([String]())
raccoonMoos.insert("Rumpus")
print(raccoonMoos)
raccoonMoos.insert("Edgar")
raccoonMoos.insert("Serena")
print(raccoonMoos)
raccoonMoos.remove("Serena")
print(raccoonMoos)
var raccoons = Set<String>()
raccoons.insert("Joey")
raccoons.insert("Rumpus")
raccoons.insert("Joey")
raccoons.insert("Carl")
raccoons.insert("Edgar")
print(raccoons)

// Enums

enum Weekday {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

var day = Weekday.Monday
day = .Friday
day = .Tuesday

print("It's \(day), \(day), gotta get down on \(day)")

var somePeople = Array<String>()
var somePlaces = Array<Int>()
var someThings = Array<Bool>()
let morePeople = [String]()
let morePlaces = [Int]()
let moreThings = [Bool]()

let boyGenius = [
    "member1": "Julien Baker",
    "member2": "Lucy Dacus",
    "member3": "Phoebe Bridgers"
]

print(boyGenius["member1", default: "Unknown"])
print(boyGenius["member2", default: "Unknown"])
print(boyGenius["member3", default: "Unknown"])

var band = [String: [String: [String]]]()
band["BoyGenius"] = ["members": ["Julien Baker", "Phoebe Bridgers", "Lucy Dacus"]]
print(band)

enum Pizzas {
    case Hawaiian, Pepperoni, Cheese, Canadian, Vegetarian
}

var myOrder = Pizzas.Hawaiian;
print(myOrder)
