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
