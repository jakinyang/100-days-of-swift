import Cocoa

func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy: () -> Void = greetUser

greetCopy()

let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}

sayHello("John")

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
}
let sortedCaptainTeam = team.sorted(by: captainFirstSorted)

print(sortedCaptainTeam)

let captainFirstTeam = team.sorted(by: {(name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2}
)

print(captainFirstTeam)

let newTeam = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let newSortedTeam = newTeam.sorted(by: { (a: String, b: String) -> Bool in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    return a < b
})

// Alternative syntax for closure with a set return value
let newSortedTeamShort = newTeam.sorted(by: { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    return a < b
})

// Trailing Closure Syntax
let newSortedTeamShorter = newTeam.sorted { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    return a < b
}


let newSortedTeamShortHand = newTeam.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    return $0 < $1
}

let reverseTeam = team.sorted {
    return $0 > $1
}
print(reverseTeam)

let tOnly = team.filter {$0.hasPrefix("T")}
print(tOnly)

let uppercaseTeam = team.map {$0.uppercased()}
print(uppercaseTeam)

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}

let rolls = makeArray(size: 10) {
    Int.random(in: 1...20)
}
print(rolls)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work!")
} second: {
    print("This is the second work!")
} third: {
    print("This is the third work!")
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter {
    !$0.isMultiple(of: 2)
}.sorted {
    return $0 < $1
}.map {
    print("\($0) is a lucky number")
}

let customizeGreetFunction = { (name: String) -> () -> Void in
    let customGreeting = {
        print("Hello, \(name)!")
    }
    return customGreeting
}

let greetJessye = customizeGreetFunction("Jessye");
greetJessye()
