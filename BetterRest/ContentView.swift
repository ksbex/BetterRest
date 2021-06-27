//
//  ContentView.swift
//  BetterRest
//
//  Created by Kevin Becker on 6/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        
        
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
