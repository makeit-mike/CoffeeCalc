//
//  ContentView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/3/21.
//

import SwiftUI

let darkBG = Color.black.opacity(0.6)
let lightBG = Color.black.opacity(0.6)

struct ContentView: View {
    @State var currentView: CurrentView = .Home
    
    var body: some View{
        ZStack {
            lightBG.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack{
                        Text("Brew Timer")
                            .fontWeight(.bold)
                            .font(.largeTitle).padding()
                        Spacer()
                    }.padding(.top, 40)
                }
                .foregroundColor(.white)
                .background(darkBG)
                .edgesIgnoringSafeArea(.all)
                
                switch currentView {
                case .Settings:
                    SettingsView()
                case .Calculate:
                    CalculatorView()
                case .Timer:
                    BrewTimerView()
                default:
                    BrewTimerView()
                }
                
                Spacer()
                FooterView(currentView: self.$currentView)
                    .padding(.top, 15)
                    .foregroundColor(.white)
                    .background(darkBG)
                    .edgesIgnoringSafeArea(.all)
            }.background(lightBG)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
