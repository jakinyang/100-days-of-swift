import Cocoa

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Woof! Wait... no! I mean Arf!")
    }
    override init(legs: Int) {
        super.init(legs: legs)
    }
}

class Corgi: Dog {
    override func speak() {
        print("Bork!")
    }
}
class Poodle: Dog {
    override func speak() {
        print("Bark!")
    }
}

class Cat: Animal {
    var isTame: Bool
    func speak(){
        print("Meow! ... Wait what's my line?")
    }
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Persian: Cat {
    override func speak() {
        print("Preow!")
    }
}
class Lion: Cat {
    override func speak() {
        print("Rawr!")
    }
}
let woof = Dog(legs: 4)
woof.speak()


protocol Building {
    var numberOfRooms: Int { get set }
    var cost: Int { get set }
    var realEstateSnake: String { get set }
    func printSummary() -> String
}
