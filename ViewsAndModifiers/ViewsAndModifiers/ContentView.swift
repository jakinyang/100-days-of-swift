//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jae Chun Yang on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText: Bool = true
    var body: some View {
        VStack {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundStyle(useRedText ? .red : .blue)
            Text("Hello, world!")
                .frame(width: 200, height: 200)
                .background(.red)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
