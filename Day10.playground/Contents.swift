import Cocoa

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)

print(red.title)

red.printSummary()

struct Employee {
    let name: String
    var vacationRemaining: Int = 14
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

var johnCena = Employee(name: "John Cena", vacationRemaining: 23)

print(johnCena.vacationRemaining)
johnCena.takeVacation(days: 2)
print(johnCena.vacationRemaining)

var daveBautista = Employee.init(name: "Dave Bautista", vacationRemaining: 17)
print(daveBautista.name)
daveBautista.takeVacation(days: 3)
