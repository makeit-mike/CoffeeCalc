//
//  FooterView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import SwiftUI

struct FooterView: View {
    @Binding var currentView: CurrentView
    var body: some View{
        HStack {
            Spacer()
            Button(action: { currentView = .Calculate }){
                VStack {
                    Image(systemName: "square.grid.3x3.topleft.filled")
                    Text("Calculate")
                }
            }
            Spacer()
            Button(action: { currentView = .Timer }){
                VStack {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Timer")
                }
            }
            Spacer()
            Button(action: { currentView = .Settings }){
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
            Spacer()
        }
    }
}
