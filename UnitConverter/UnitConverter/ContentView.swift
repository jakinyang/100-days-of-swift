//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jae Chun Yang on 2023-08-15.
//

import SwiftUI

struct ContentView: View {
    @State private var unitSelection: String = "Temperature"
    @State private var originUnitSelection: String = "Celcius"
    @State private var targetUnitSelection: String = "Fahrenheit"
    @State private var originValue: Double = 0.0
    
    private var selectedUnits: [String] {
        return units[unitSelection] ?? ["Celcius", "Fahrenheit", "Kelvin"]
    }
    
    var originUnit: Dimension {
        let selectedUnit = unitConversionTypes[unitSelection] ?? [
            "Celcius": UnitTemperature.celsius,
            "Fahrenheit": UnitTemperature.celsius,
            "Kelvin": UnitTemperature.kelvin
        ]
        let unit = selectedUnit[originUnitSelection] ?? UnitTemperature.celsius
        return unit as! Dimension
    }
    
    var targetUnit: Dimension {
        let selectedUnit = unitConversionTypes[unitSelection] ?? [
            "Celcius": UnitTemperature.celsius,
            "Fahrenheit": UnitTemperature.celsius,
            "Kelvin": UnitTemperature.kelvin
        ]
        let unit = selectedUnit[targetUnitSelection] ?? UnitTemperature.fahrenheit
        return unit as! Dimension
    }
    
    
    private var conversionResult: Double {
        let measurement = Measurement(value: originValue, unit: originUnit)
        let result = measurement.converted(to: targetUnit)
        let finalResult = result.value
        
        return finalResult
    }
    
    
    private let unitTypes: [String] = ["Temperature", "Length", "Time", "Volume"]
    
    private let units: [String: [String]] = [
        "Temperature": ["Celcius", "Fahrenheit", "Kelvin"],
        "Length": ["Meters", "Kilometers", "Feet", "Yards", "Miles"],
        "Time": ["Seconds", "Minutes", "Hours"],
        "Volume": ["Millilitres", "Litres", "Cups", "Pints", "Gallons"]
    ]
    
    private let unitConversionTypes: [String: [String: Unit]] = [
        "Temperature": [
            "Celcius": UnitTemperature.celsius,
            "Fahrenheit": UnitTemperature.fahrenheit,
            "Kelvin": UnitTemperature.kelvin
        ],
        "Length": [
            "Meters": UnitLength.meters,
            "Kilometers": UnitLength.kilometers,
            "Feet": UnitLength.feet,
            "Yards": UnitLength.yards,
            "Miles": UnitLength.miles
        ],
        "Time": [
            "Seconds": UnitDuration.seconds,
            "Minutes": UnitDuration.minutes,
            "Hours": UnitDuration.hours,
        ],
        "Volume": [
            "Millilitres": UnitVolume.milliliters,
            "Litres": UnitVolume.liters,
            "Cups": UnitVolume.cups,
            "Pints": UnitVolume.pints,
            "Gallons": UnitVolume.gallons
        ]
    ]

    var body: some View {
        NavigationView {
            Form {
                // Unit Type Selector
                Section {
                    Picker("Kind of unit", selection: $unitSelection) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("What kind of unit would you like to convert?")
                }
                
                // Origin Unit Selector
                Section {
                    Picker("From:", selection: $originUnitSelection) {
                        ForEach(selectedUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("", value: $originValue, format: .number)
                } header: {
                    Text("What unit are you converting from?")
                }
                // Target Unit Selector
                Section {
                    Picker("To:", selection: $targetUnitSelection) {
                        ForEach(selectedUnits, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("What unit are you converting to?")
                }
                // Conversion Result
                Section {
                    Text(conversionResult, format: .number)
                } header: {
                    Text("Converted Result")
                }
            }
            .navigationTitle("Unit Converter")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
