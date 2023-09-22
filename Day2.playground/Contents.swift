import Cocoa

let file = "paris.jpg"
print(file.hasSuffix(".jpg"))
let num = 120
print(num.isMultiple(of: 3))

var alive = true
print(alive)
alive.toggle()
print(alive)

let first = "Hello"
let second = ". "
let third = "World!"

let greeting = first + second + third
print(greeting)


let saying = "I like saying \(first + second + third)"
print(saying)

let celcius: Float = 100
let farenheit: Float = (celcius * 9 / 5) + 32
print("\(celcius)° Degrees Celcius")
print("\(farenheit)° Degrees Farenheit")

let lyricOne = "You "
let lyricTwo = "belong "
let lyricThree = "with "
let lyricFour = "me!"
let chorus = lyricOne + lyricTwo + lyricThree + lyricFour
print(chorus)

let chorusPart = "Baby, why can't you see, \(chorus)"
print(chorusPart)
