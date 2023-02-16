import Cocoa

var beetles = ["John", "Paul", "George", "Ringo"]
let numbers = [1, 2, 3, 4, 5, 6]
var temperatures = [1.1, 2.3, 4.5]

beetles.append("Adrian")

var scores = Array<Int>()
scores.append(100)
scores.append(20)
scores.append(39)

scores

var albums = Array<String>()

albums.append("Folklore")
albums.append("Fearless")
albums.append("1989")

print(albums.count)

albums.remove(at: 2)

print(albums)

print(albums.contains("Fearless"))

numbers.reversed()
numbers

scores.sort()

