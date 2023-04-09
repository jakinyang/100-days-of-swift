//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jae Chun Yang on 2023-04-08.
//

import SwiftUI

struct ContentView: View {
    
    func executeDelete() {
        print("Now Deleting")
    }
    
    var body: some View {
        Image(systemName: "pencil")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
