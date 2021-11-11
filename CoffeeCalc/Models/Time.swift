//
//  Time.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import Foundation

struct Time {
    var Minute: Int
    var Second: Int
    
    func totalSeconds() -> Int {
        return Minute * 60 + Second
    }
    
    mutating func elapseSecond() {
        if self.Second - 1 == 0 && self.Minute == 0 {
            self.Second = 0
        }
        else if self.Second - 1 == 0 {
            self.Minute -= 1
            self.Second = 59
        }
        else {
            self.Minute -= 1
        }
    }
    
    func TimeRemaining() -> String{
        return "\(String(Minute).padLeft(toLength: 2, withPad: "0")):\(String(Second).padLeft(toLength: 2, withPad: "0"))"
    }
}
