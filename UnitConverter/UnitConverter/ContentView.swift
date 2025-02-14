//
//  ContentView.swift
//  UnitConverter
//
//  Created by Jae Chun Yang on 2024-11-15.
//

import SwiftUI

func conversionFunction(inputLength: Double, inputUnit: UnitLength, targetUnit: UnitLength) -> Double {
    let inputMeasurement = Measurement<UnitLength>(value: inputLength, unit: inputUnit)
    let convertedMeasurement = inputMeasurement.converted(to: targetUnit)
    
    return convertedMeasurement.value
}

let conversionLookUpTable: [String: UnitLength] = [
    "Kilometer": UnitLength.kilometers,
    "Meter": UnitLength.meters,
    "Centimeter": UnitLength.centimeters,
    "Mile": UnitLength.miles,
    "Yard": UnitLength.yards,
    "Foot": UnitLength.feet,
    "Inch": UnitLength.inches,
]

struct ContentView: View {
    @State private var temperatureConversionSelection: String = "C"
    @State private var temperature: Double = 0.0
    @FocusState private var temperatureFieldIsFocused: Bool
    
    let temperatures: [String] = ["C", "F"]
    
    var convertedTemperature: String {
        return if temperatureConversionSelection == "F" {
            "\((temperature - 32) * 5 / 9 )"
        } else if temperatureConversionSelection == "C" {
            "\((temperature * 9 / 5) + 32)"
        } else {
            "Error"
        }
    }
    
//    Length
//    Metric selection
    @State private var inputSelection: String = "Meter"
    
//    Imperial selction
    @State private var outputSelection: String = "Foot"
//    Input value
    @State private var lengthInputValue: Double = 0
//    Length Focused State
    @FocusState private var lengthInputIsFocused: Bool
//    Output value
    var convertedLength: Double {
        conversionFunction(inputLength: lengthInputValue, inputUnit: conversionLookUpTable[inputSelection] ?? UnitLength.meters, targetUnit: conversionLookUpTable[outputSelection] ?? UnitLength.feet)
    }
    
//    Metric Options
    let lengthOptions: [String] = ["Kilometer", "Meter", "Centimeter", "Mile", "Yard", "Foot", "Inch"]
    
    var body: some View {
        NavigationStack {
            Form {
//                Temperature
                Section ("Temperature") {
//                    Input temperature and unit selection
                    HStack{
                        TextField("Temperature", value: $temperature, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($temperatureFieldIsFocused)
                        Picker("Temperature Unit", selection: $temperatureConversionSelection) {
                            ForEach(temperatures, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
//                    Every time editing is finished it should update the value
                    Text(convertedTemperature)
                    
                }
//                Length
                Section ("Length") {
                    VStack{
                        HStack {
                            TextField("Length", value: $lengthInputValue, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($lengthInputIsFocused)
                            Picker("", selection: $inputSelection) {
                                ForEach(lengthOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        HStack {
                            Text(convertedLength, format: .number)
                            Picker("", selection: $outputSelection) {
                                ForEach(lengthOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
