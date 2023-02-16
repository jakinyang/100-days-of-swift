import Cocoa

var surname: String = "Judy"
var score: Double = 34

let name: String = "Rick"
let num: Int = 13
let pi: Double = 3.14
let isItTrue: Bool = true

let albums: [String] = ["Fearless", "1989"]
var user: [String: Int] = ["Id": 19]
var books: Set<String> = Set(["LOTR", "Narnia", "Hunger Games"])

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light

var nextStyle: UIStyle = .dark

var strings: [String] = ["a", "b", "c", "a"]
var setString: Set<String> = Set(strings)

print(strings.count)
print(setString.count)



