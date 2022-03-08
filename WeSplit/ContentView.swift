//
//  ContentView.swift
//  WeSplit
//
//  Created by Peter Fischer on 2/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @FocusState private var amountIsFocus : Bool
    
    var totalPlusTip : Double {
        let tipAmount : Double = (checkAmount / 100) * Double(tipPercentage)
        return checkAmount + tipAmount
    }
    
    var calculatedTip : Double {
        
        let numPeople = Double(numberOfPeople + 2) // Need to offset by 2 due to picker offset
        
        let tipAmount = (checkAmount / 100.0) * Double(tipPercentage)
        let totalAmount = tipAmount + checkAmount
        let total = totalAmount / numPeople
        
        return total
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    let currencyFormat :  FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
      
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    
                } header: {
                    Text("Tip Percentage")
                }
                
                Section {
                    Text(totalPlusTip, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total Plus Tip")
                }
                
                Section {
                    Text(calculatedTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
.previewInterfaceOrientation(.portrait)
    }
}
