//
//  ContentView.swift
//  BetterRest
//
//  Created by Jae Chun Yang on 2024-11-28.
//

import SwiftUI
import CoreML

struct ContentView: View {
//    App State Variables
    @State private var wakeUp: Date = defaultWakeUpTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
//    Alert state variables
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date{
        var components = DateComponents()
        components.hour = 5
        components.minute = 30
        return Calendar.current.date(from: components) ?? .now
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute  = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime!"
        }
        
        showingAlert = true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Wake up time") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
                }
//                Text("When do you want to wake up?")
//                    .font(.headline)
                
//                Text("Desired amount of sleep")
//                    .font(.headline)
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in:0...20)
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(0`..<20) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                }
//                Text("Daily coffee intake")
//                    .font(.headline)
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text(alertMessage)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
