import Cocoa
// Write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:
// You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
// If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
// You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
// If you can’t find the square root, throw a “no root” error.

enum SquareRootError: Error {
    case noRoot
}
func getRoot(of number: Int) throws -> Int {
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
            throw SquareRootError.noRoot
}
    do {
        let root = try getRoot(of: 16)
        print(root)
    } catch SquareRootError.noRoot {
        print("No Root")
    }

func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 15)

// Error Handling

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    if password == "12345" {
        throw PasswordError.obvious
    }
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "125"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("There was an error: the password was too short!")
} catch PasswordError.obvious {
    print("There was an error: the password was too obvious!")
} catch {
    print("There was an error!")
}

// Checkpoint 4

enum BoundsError: Error {
    case tooLarge, tooSmall, noRoot

}

func getSquare(number: Int) throws -> Int {
    if (number < 1) {
        throw BoundsError.tooSmall
    }
    if (number > 10_000) {
        throw BoundsError.tooLarge
    }
    for i in 1...100 {
        if number == i * i {
            return i
        }
    }
    throw BoundsError.noRoot
}

do {
    let result = try getSquare(number: 9)
    print("The Integer Square root is \(result)")
} catch BoundsError.tooLarge {
    print("Number was too large")
} catch BoundsError.tooSmall {
    print("Number was too small")
} catch BoundsError.noRoot {
    print("There is no integer square root for that number")
}
