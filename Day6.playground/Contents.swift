import Cocoa

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1...20 {
    if (i == 1) {
        print("There is 1 raccoon on the deck!")
    } else {
        print("There are \(i) raccoons on the deck!")
    }
}
