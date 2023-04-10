//
//  ContentView.swift
//  TechniqueProject1
//
//  Created by Jae Chun Yang on 2023-04-09.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack (spacing: 10){
            CapsuleText(text: "First")
            Text("Second")
                .titleStyle()
        }
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
