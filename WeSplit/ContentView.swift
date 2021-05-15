//
//  ContentView.swift
//  WeSplit
//
//  Created by Mahmoud Fouad on 5/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    private let tipPercentages = [10, 15, 20, 25, 0]
    private var totalPerPerson: Double {
        let peopleCount  =  Double(numberOfPeople + 2)
        let tipSelection =  Double(tipPercentages[tipPercentage])
        let orderAmount  =  Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach( 2 ..< 100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave ?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach( 0..<tipPercentages.count ) {
                            Text("\(tipPercentages[$0]) %")
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section {
                    Text("$ \(self.totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
