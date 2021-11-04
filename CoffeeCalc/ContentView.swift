//
//  ContentView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/3/21.
//

import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0)).cornerRadius(4)
                }
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0)).cornerRadius(4)
                }
            }
            HStack {
                Text("Match color: ")
                
                Text("R: \(Int(rTarget * 255.0))")
                Text("G: \(Int(gTarget * 255.0))")
                Text("B: \(Int(bTarget * 255.0))")
            }
            HStack {
                Text("Current color: ")
                
                Text("R: \(Int(rGuess * 255.0))")
                Text("G: \(Int(gGuess * 255.0))")
                Text("B: \(Int(bGuess * 255.0))")
            }
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }
    }
}
