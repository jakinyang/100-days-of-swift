//
//  ContentView.swift
//  Challenge1
//
//  Created by Jae Chun Yang on 2023-04-08.
//

import SwiftUI

struct TemperatureConverter {
    enum TemperatureUnit: String, CaseIterable {
        case fahrenheit = "Fahrenheit"
        case celsius = "Celsius"
        case kelvin = "Kelvin"
    }
    
    static func convert(_ value: Double, from inputUnit: TemperatureUnit, to outputUnit: TemperatureUnit) -> Double {
        if inputUnit == outputUnit {
            return value
        }
        
        let intermediateValueInCelsius: Double
        
        switch inputUnit {
        case .fahrenheit:
            intermediateValueInCelsius = (value - 32) * 5 / 9
        case .celsius:
            intermediateValueInCelsius = value
        case .kelvin:
            intermediateValueInCelsius = value - 273.15
        }
        
        let convertedValue: Double
        
        switch outputUnit {
        case .fahrenheit:
            convertedValue = (intermediateValueInCelsius * 9 / 5) + 32
        case .celsius:
            convertedValue = intermediateValueInCelsius
        case .kelvin:
            convertedValue = intermediateValueInCelsius + 273.15
        }
        
        return convertedValue
    }
}

struct TemperatureUnitPicker: View {
    var title: String
    @Binding var selection: TemperatureConverter.TemperatureUnit
    
    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(TemperatureConverter.TemperatureUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue)
            }
        }
    }
}

struct ContentView: View {
    let units = ["Fahrenheit", "Kelvin", "Celcius"]
    @State private var inputSelection = TemperatureConverter.TemperatureUnit.fahrenheit
    @State private var outputSelection = TemperatureConverter.TemperatureUnit.celsius
    @State private var inputValue: Double = 0.0
    
    var outputValue: Double {
        TemperatureConverter.convert(inputValue, from: inputSelection, to: outputSelection)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Units to Convert")) {
                    TemperatureUnitPicker(title: "Input Unit", selection: $inputSelection)
                    TextField("Temperature", value: $inputValue, format: .number)
                }
                Section(header: Text("Target Unit")) {
                    TemperatureUnitPicker(title: "Output Unit", selection: $outputSelection)
                    Text("Temperature in \(outputSelection.rawValue): \(String(format: "%.2f", outputValue))")
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
