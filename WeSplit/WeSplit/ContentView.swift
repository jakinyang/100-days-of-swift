//
//  ContentView.swift
//  WeSplit
//
//  Created by Jae Chun Yang on 2024-10-01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople: Int = 0
    @State private var tipValue: Int = 15
    @FocusState private var amountIsFocused: Bool
    let tipPercentages: [Int] = [0, 10, 12, 15, 18, 20, 25]
    
    var totalPerPerson: Double {
        let tipAmount: Double = Double(checkAmount) / 100 * Double(tipValue)
        let peopleTotal: Double = Double(numberOfPeople + 2)
        let grandTotal = checkAmount + tipAmount
        let individualTotal = grandTotal / peopleTotal
        return  individualTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
//                Check Amount
                Section ("Bill Amount"){
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
//                Number of People
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
//                Tip Value
                Section("How much tip would you like to leave?") {
                    Picker("Tip Percentage", selection: $tipValue) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
//                Total Per Person
                Section ("Total Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipValue == 0 ? .red : .primary)
                }
            }
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
