var greeting = "Hello, playground"
print(greeting)

var name = "Ted"
name = "Rebecca"
print(name)

let user = "Daphne"
print(user)

let actor = "Tom Cruise 🏃"

let quote = "He tapped a sign saying \"Believe\""

let movie = """
A day in
the life of an
Apple engineer
"""
print(movie)

print(actor.count)

print(quote.hasPrefix("He"))
print(quote.hasSuffix("Away."))

let employee: [String: String] = [
    "name": "Taylor",
    "job": "singer"
]
print(employee)
print(employee["color", default: "n/a"])
