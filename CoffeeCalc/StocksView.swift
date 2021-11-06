//
//  ContentView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/3/21.
//

import SwiftUI
import Combine

struct StocksView: View {
    var body: some View{
        VStack{
            HeaderView()
            BodyView()
            FooterView()
        }.padding(10).background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.145)).foregroundColor(.white).preferredColorScheme(.dark)
    }
}

struct HeaderView: View {
    var body: some View{
        VStack{
            Text("Investment Quest").fontWeight(.semibold)
                .font(.title).padding(10)
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 90,
            alignment: .topLeading
        )
    }
}

struct BodyView: View {
    var body: some View{
        VStack{
            StockSearchView().frame(alignment: .center).padding(20)
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 700,
            alignment: .topLeading
        ).padding(-10)
    }
}

struct FooterView: View {
    var body: some View{
        VStack{
            HStack{
                FooterNavButtonView(iconName: "magazine", btnText: "Portfolio")
                FooterNavButtonView(iconName: "magnifyingglass", btnText: "Search")
                FooterNavButtonView(iconName: "gear", btnText: "Settings")
            }.font(.title2)
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 50,
            alignment: .center
        ).opacity(0.6)
    }
}

struct FooterNavButtonView: View {
    @State var iconName: String
    @State var btnText: String
    
    var body: some View{
        Button(action: {}) {
            VStack {
                Image(systemName: iconName)
                    .font(.title).frame(width: 35, height: 35)
                Text(btnText)
                    .fontWeight(.light)
                    .font(.caption)
            }.frame(width: 50, height: 50, alignment: .top)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(20)
        }
    }
}

struct StockSearchView: View {
    @State private var stockSymbol: String = ""
    @State private var showStockInfo: Bool = false
    @State private var showInvestView: Bool = false
    @State private var stockPrice: Double = Double.random(in: 20 ..< 1000)
    @State private var stockGrowth: Double = Double.random(in: 0 ..< 1)
    @State private var stockShareHolders: Int = Int.random(in: 50 ..< 10000000)
    var body: some View{
        VStack{
            HStack{
                Text("Stock Symbol:")
                TextField("", text: $stockSymbol)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(20)
                    .frame(width: 120, alignment: .topLeading)
                    .font(.title).opacity(0.5)
                    .onReceive(Just($stockSymbol)) { _ in limitStockSymbol(5) }
                
                Button(action: {showStockInfo = true}) {
                    Image(systemName: "magnifyingglass")
                }.padding(10)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
            }.frame(width: 300, height: 60)
            
            if(showStockInfo){
                Text("Stock information for \(stockSymbol)").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
                Text("Stock Price: $\(stockPrice)").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
                Text("Estimated Growth: \(stockGrowth)%").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
                Text("Shareholders: \(stockShareHolders)").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
                
                Button(action: {self.showInvestView.toggle()}) {
                    HStack{
                        Image(systemName: "dollarsign.square.fill")
                        Text("Invest")
                    }
                }.frame(width: 80, alignment: .topLeading).padding(10)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .sheet(isPresented: $showInvestView) {
                        InvestView()
                    }
            }
        }.frame(width: 300, height: 300, alignment: .topLeading)
        
    }
    func limitStockSymbol(_ upper: Int) {
        stockSymbol = String(stockSymbol.prefix(upper)).uppercased()
    }
}

struct InvestView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var dateOfBirth: Date = Date.now
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    
    @State var stockSymbol: String = ""
    @State var showStockInfo: Bool = false
    @State var showInvestView: Bool = false
    @State var stockPrice: Double = 0
    
    var body: some View{
        VStack{
            Text("Invest in me senpai")
            UserInfoTextInput(viewResponse: "Full Name:", text: fullName)
            UserInfoTextInput(viewResponse: "Email Address:", text: email)
            UserInfoTextInput(viewResponse: "Home Address:", text: address)
            UserInfoTextInput(viewResponse: "Phone Number:", text: phoneNumber)
            
            HStack{
                Text("Date of Birth:").frame(width: 200)
                DatePicker(
                    "Start Date",
                    selection: $dateOfBirth,
                    displayedComponents: [.date]
                ).frame(width: 120, alignment: .topLeading)
            }
            
            HStack{
                //Num shares use var
            }
            HStack{
                // total cost = stockCost * numShares
            }
        }
    }
}

struct UserInfoTextInput: View {
    @State var viewResponse: String = ""
    @State var text: String = ""
    var body: some View{
        HStack{
            Text(viewResponse).frame(width: 200)
            TextField("", text: $text)
                .foregroundColor(.white)
                .background(.gray)
                .padding(10)
                .cornerRadius(40)
                .frame(width: 120, alignment: .topLeading)
                .font(.title).opacity(0.5)
        }
    }
}

struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView()
    }
}

