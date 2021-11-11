//
//  CalculatorView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

import SwiftUI

let btns: [String] = ["1","2","3","4","5","6","7","8","9","0","+","-","/","="]

struct CalculatorView: View {
    @State var result: String = ""
    @State var mathExpr: String = ""
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                
                ScrollView (.horizontal){
                    ZStack {
                        Color.gray
                        HStack{
                            Text("\(ComputedResult()) ").font(.system(size: 70))
                        }.background(.gray.opacity(0.3)).frame(alignment: .trailing)
                    }
                }.frame(height: 80, alignment: .bottomTrailing)
                
                HStack{
                    Spacer()
                    Text("\(mathExpr) ")
                        .font(.system(size: 70))
                }.frame(height: 80, alignment: .bottomTrailing)
                
                HStack{
                    CalcActionButton(btnText: "AC", mathExpr: $mathExpr, function: {mathExpr = ""})
                    CalcActionButton(btnText: "+-", mathExpr: $mathExpr, function: {mathExpr = "-\(mathExpr)"})
                    CalcActionButton(btnText: "%",  mathExpr: $mathExpr, function: {mathExpr += "%"})
                    CalcActionButton(btnText: "/",  mathExpr: $mathExpr, function: {mathExpr += "/"})
                }
                HStack{
                    CalcButton(btnText: "7", mathExpr: $mathExpr)
                    CalcButton(btnText: "8", mathExpr: $mathExpr)
                    CalcButton(btnText: "9", mathExpr: $mathExpr)
                    CalcActionButton(btnText: "*", mathExpr: $mathExpr, function: {mathExpr += "*"})
                }
                HStack{
                    CalcButton(btnText: "4", mathExpr: $mathExpr)
                    CalcButton(btnText: "5", mathExpr: $mathExpr)
                    CalcButton(btnText: "6", mathExpr: $mathExpr)
                    CalcActionButton(btnText: "-", mathExpr: $mathExpr, function: {mathExpr += "-"})
                }
                HStack{
                    CalcButton(btnText: "1", mathExpr: $mathExpr)
                    CalcButton(btnText: "2", mathExpr: $mathExpr)
                    CalcButton(btnText: "3", mathExpr: $mathExpr)
                    CalcActionButton(btnText: "+", mathExpr: $mathExpr, function: {mathExpr += "+"})
                }
                HStack{
                    CalcButton(btnText: "0", mathExpr: $mathExpr, width: 2)
                    CalcButton(btnText: ".", mathExpr: $mathExpr)
                    CalcActionButton(btnText: "=", mathExpr: $mathExpr, function: {mathExpr += "="})
                }
            }
        }.foregroundColor(.white)
    }
    
    func ComputedResult() -> String {
       /* var output = ""
        do {
            try ObjC.catchException {
                let expression = NSExpression(format: mathExpr)
                let value = expression.expressionValue(with: nil, context: nil) as? Int
                if(value == nil){
                    output =  ""
                }
                output = value.toString()
            }
        }
        catch {
            return ""
        }
        return output*/
        return mathExpr
    }
}

struct CalcActionButton: View {
    @State var btnText: String
    @Binding var mathExpr: String
    
    @State var function: () -> Void = {}
    
    var body: some View {
        Button (action: function) {
            Text("\(btnText)").frame(width: 90, height: 90).font(.title)
        }.frame(width: 90, height: 90).background(.gray.opacity(0.15)).cornerRadius(15)
        
    }
}

struct CalcButton: View {
    @State var btnText: String
    @Binding var mathExpr: String
    @State var width: Int = 1
    
    var body: some View {
        Button (action: {mathExpr += btnText}) {
            Text("\(btnText)").frame(width: 90 * CGFloat(width), height: 90).font(.title)
        }.frame(width: 90 * CGFloat(width), height: 90).background(.gray.opacity(0.1)).cornerRadius(15)
        
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().background(.black.opacity(0.7))
    }
}
