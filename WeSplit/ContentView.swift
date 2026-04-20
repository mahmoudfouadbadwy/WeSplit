//
//  ContentView.swift
//  WeSplit
//
//  Created by Mahmoud Fouad on 5/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private let startIndexForPeoplePicker = 2
    private var totalPerPerson: Double {
        let peopleCount  =  Double(numberOfPeople + startIndexForPeoplePicker)
        let amountPerPerson = totalCheckAmount / peopleCount
        return amountPerPerson
    }
    private var totalCheckAmount: Double {
        let orderAmount  =  Double(checkAmount) ?? 0
        let tipSelection =  Double(tipPercentage)
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount",
                              text: $checkAmount)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number Of People",
                           selection: $numberOfPeople) {
                        ForEach( 2 ..< 100 ) {
                            Text("\($0) People")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave ?") {
                    Picker("Tip Percentage",
                           selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Total Check Amount") {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationBarTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
