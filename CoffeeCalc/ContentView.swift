//
//  ContentView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/3/21.
//

import SwiftUI

enum CurrentView {
    case Calculate, Timer, Settings, Home
}

struct ContentView: View {
    @State var currentView: CurrentView = .Home
    
    var body: some View{
        NavigationView{
            VStack {
                ZStack{
                    Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
                    switch currentView {
                    case .Settings:
                        SettingsView()
                    case .Calculate:
                        CalculatorView()
                    case .Timer:
                        BrewTimerView()
                    default:
                        HomeView()
                    }
                }
                Spacer()
                FooterView(currentView: self.$currentView).padding(.top, 10)
            }.background(Color(red: 155/255, green: 100/255, blue: 60/255))
        }.navigationTitle("Coffee Calc")
        
        
    }
}

struct HomeView: View {
    var body: some View{
        VStack{
            Text("Home View")
        }
    }
}

struct SettingsView: View {
    var body: some View{
        VStack{
            Text("Settings View")
        }
    }
}

struct CalculatorView: View {
    var body: some View{
        VStack{
            Text("Calculator View")
        }
    }
}
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
        }.foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BrewTimerView : View {
    @State var start = false
    @State var to : CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var totalTime: CGFloat = 90
    var body: some View{
        ZStack{
            VStack{
                ZStack{
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    VStack{
                        
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                    }
                }
                
                HStack(spacing: 20){
                    Button(action: {
                        if self.count == 0{
                            self.count = Int(totalTime)
                            withAnimation(.default){
                                self.to = 0
                            }
                        }
                        self.start.toggle()
                    }) {
                        
                        HStack(spacing: 15){
                            
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            
                            Text(self.start ? "Pause" : "Start")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button(action: {
                        self.count = 0
                        withAnimation(.default){
                            self.to = 0
                        }
                        
                    }) {
                        HStack(spacing: 15){
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.black)
                            
                            Text("Restart")
                                .foregroundColor(.black)
                            
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule().stroke(Color.black.opacity(0.45), lineWidth: 2)
                        )
                        .shadow(radius: 6)
                    }
                }
                .padding(.top, 25)
            }
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        .onReceive(self.time) { (_) in
            if self.start{
                if self.count != 0{
                    self.count -= 1
                    withAnimation(.default){
                        self.to = CGFloat(self.count) / totalTime
                    }
                }
                else{
                    self.start.toggle()
                    self.Notify()
                }
            }
        }
    }
    
    func Notify(){
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Brew completed"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}
