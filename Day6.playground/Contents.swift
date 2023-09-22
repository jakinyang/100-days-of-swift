import Cocoa

// For Loop

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1..<21 {
    if (i == 1) {
        print("There is 1 raccoon on the deck!")
    } else {
        print("There are \(i) raccoons on the deck!")
    }
}

// While Loop

var countdown = 10
while countdown > 0 {
    print(countdown)
    countdown -= 1
}

print("Blast off!")


// FizzBuzz
for i in 1...100 {
    if i % 3 == 0 && i % 5 == 0 {
        print("FizzBuzz")
    } else if i % 3 == 0{
        print("Fizz")
    } else if i % 5 == 0 {
        print("Buzz")
    } else {
        print(i)
    }
}

