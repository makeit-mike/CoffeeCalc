//
//  Extensions.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import Foundation

extension Optional where Wrapped == Int {
    func toString() -> String {
        if self == nil {
            return ""
        }
        return String(self!)
    }
    
    func toForcedInt() -> Int {
        return self ?? 0
    }
    
    func toForcedInt(defaultReturn: Int) -> Int {
        return self ?? defaultReturn
    }
}

extension String {
    
    func padLeft(toLength: Int, withPad pad: String) -> String {
        return
            self
                .reverse()
                .padding(toLength: toLength, withPad: pad, startingAt: 0)
                .reverse()
    }
    
    func padRight(toLength: Int, withPad pad: String) -> String {
        return
            self
                .padding(toLength: toLength, withPad: pad, startingAt: 0)
    }
    
    
    func reverse() -> String {
        return String(self.reversed())
    }
}


/*
 
 
 func TimerSecondHit(mins: Int, seconds: Int) -> Time {
     if seconds - 1 == 0 && mins == 0 {
         return Time(minutes: 0, seconds: 0)
     }
     if seconds - 1 == 0 {
         return Time(minutes: mins-1, seconds: 59)
     }
     
     return Time(minutes: mins, seconds: self.seconds - 1)
 }
 
 func TimerFinished(mins: Int, seconds: Int) -> Bool {
     return (mins == 0 && seconds == 0)
 }
 
 func DrawTimeRemaining(mins: Int, seconds: Int) -> String{
     return "\(String(mins).padLeft(toLength: 2, withPad: "0")):\(String(seconds).padLeft(toLength: 2, withPad: "0"))"
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


struct Time {
 var minutes: Int
 var seconds: Int
}

 
 */
