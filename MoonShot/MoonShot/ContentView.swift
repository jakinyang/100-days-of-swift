//
//  ContentView.swift
//  MoonShot
//
//  Created by Jae Chun Yang on 2025-02-11.
//

import SwiftUI

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

extension Bundle {
    
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Moo")
        }
    }
}

#Preview {
    ContentView()
}
