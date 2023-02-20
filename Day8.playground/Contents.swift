import Cocoa

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
