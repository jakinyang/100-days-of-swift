import Cocoa

struct Car {
    private var model: String
    private var seats: Int
    var gear: Int
    mutating func raiseGear() {
        gear += 1
    }
    mutating func lowerGear() {
        gear -= 1
    }
}
