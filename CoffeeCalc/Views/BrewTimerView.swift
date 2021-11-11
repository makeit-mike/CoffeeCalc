//
//  BrewTimerView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import SwiftUI

struct BrewTimerView: View {
    @State var timerSeconds: CGFloat = 120
    var body: some View {
            ZStack {
                VStack{
                    Spacer()
                    TimerView(totalTime: timerSeconds)
                    ScrollView (.horizontal){
                        HStack {
                            PresetButton(ts: $timerSeconds, presetName: "Tea", interval: "2:30")
                            PresetButton(ts: $timerSeconds,presetName: "Coffee", interval: "3:00")
                            CustomButton(ts: $timerSeconds,presetName: "Custom", interval: "X:XX")
                        }
                    }
                    Spacer()
                }
            }.colorScheme(.dark)
        }
}

struct PresetButton: View {
    @Binding var ts: CGFloat
    @State var presetName: String
    @State var interval: String
    @State var function: () -> Void = {}
    
    var body: some View{
        Button(action: function) {
            VStack{
                Text(presetName)
                    .font(.system(size: 11))
                    .padding(.bottom)
                Text(interval)
            }
            .padding(10)
            .foregroundColor(.white)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .shadow(radius: 6)
        .background(.black.opacity(0.7))
        .clipShape(Capsule())
        .cornerRadius(10)
        .padding()
    }
}

struct CustomButton: View {
    @Binding var ts: CGFloat
    @State var presetName: String
    @State var interval: String
    
    var body: some View{
        Button(action: {}) {
            VStack{
                Text(presetName)
                    .font(.system(size: 11))
                    .padding(.bottom)
                Text(interval)
            }
            .padding(10)
            .foregroundColor(.white)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .shadow(radius: 6)
        .background(.black.opacity(0.7))
        .clipShape(Capsule())
        .cornerRadius(10)
        .padding()
    }
}

struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}


struct BrewTimerView_Previews: PreviewProvider {
    static var previews: some View {
        BrewTimerView().background(.black.opacity(0.9))
    }
}
