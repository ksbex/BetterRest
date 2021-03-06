//
//  ContentView.swift
//  BetterRest
//
//  Created by Kevin Becker on 6/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("When do you want to wake up?")) {
//                VStack (alignment: .leading, spacing: 0)  {
//                     Text("When do you want to wake up?")
//                         .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section (header: Text("Desired amount of sleep")) {
//                VStack (alignment: .leading, spacing: 0)  {
//                    Text("Desired amount of sleep")
//                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section (header: Text("Daily coffee intake")) {
//                VStack (alignment: .leading, spacing: 0)  {
//                    Text("Daily coffee intake")
//                        .font(.headline)
                    Picker ("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(0 ..< 21) {
                            Text("\($0) " + ($0 == 1 ? "cup" : "cups"))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                        
//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
                    
                }
                Section (header: Text("Recommended bedtime")){
                    Text(calculateBedtime())
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing:
//                Button(action: calculateBedtime) {
//                    Text("Calculate")
//                }
//            )
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        // let model = SleepCalculator()
        let bedTime: String
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let model: SleepCalculator = try SleepCalculator(configuration: .init())
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
            bedTime = formatter.string(from: sleepTime)
        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was an error caclulating your bedtime"
            bedTime = "Error"
        }
//        showingAlert = true
          return bedTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
