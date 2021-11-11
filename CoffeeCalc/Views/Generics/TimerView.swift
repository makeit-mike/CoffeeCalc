//
//  TimerView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import SwiftUI

struct TimerView : View {
    @State var totalTime: CGFloat
    
    @State var start = false
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Set in 'OnAppear'
    @State var to : CGFloat = 0
    @State var count = 0
    
    var body: some View{
        ZStack{
            VStack{
                ZStack{
                    // Background Circle
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    // Timer Circle
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    
                    // Time Left Counter
                    VStack{
                        Text("\(DrawTimeRemaining(total: self.count))")
                            .font(.system(size: 65))
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                    }
                }
                
                HStack(spacing: 20){
                    // Play Button
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
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    // Reset Button
                    Button(action: {
                        self.count = Int(totalTime)
                        withAnimation(.default){
                            self.to = totalTime
                        }
                    }) {
                        HStack(spacing: 15){
                            Image(systemName: "arrow.clockwise").foregroundColor(.white)
                            Text("Restart").foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule().stroke(Color.gray.opacity(0.45), lineWidth: 2)
                        )
                        .shadow(radius: 6)
                    }
                }.padding(.top, 25)
            }
        }
        .onAppear(perform: {
            self.to = totalTime
            self.count = Int(totalTime)
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
    
    func DrawTimeRemaining(total: Int) -> String{
        let nmins = Int(total / 60)
        let nseconds = total % 60
        return "\(String(nmins).padLeft(toLength: 2, withPad: "0")):\(String(nseconds).padLeft(toLength: 2, withPad: "0"))"
    }
    
    func TimeToSeconds(mins: Int, seconds: Int) -> Int {
        return mins * 60 + seconds
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


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalTime: 120).background(.black.opacity(0.9))
    }
}
