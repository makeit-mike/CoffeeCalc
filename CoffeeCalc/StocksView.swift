//
//  ContentView.swift
//  CoffeeCalc
//
//  Created by Michael Jones on 11/3/21.
//

import SwiftUI

struct StocksView: View {
    var body: some View{
        VStack{
            HeaderView()
            BodyView()
            FooterView()
        }.padding(10).background(.black).foregroundColor(.white).preferredColorScheme(.dark)
    }
}

struct HeaderView: View {
    var body: some View{
        VStack{
            Text("Investment Quest").fontWeight(.semibold)
                .font(.title).padding(-1)
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 48,
            alignment: .topLeading
        )
    }
}

struct BodyView: View {
    var body: some View{
        VStack{
            StockSearchView().frame(alignment: .center)
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 700
        ).padding(-10)
    }
}

struct FooterView: View {
    var body: some View{
        VStack{
            HStack{
                FooterNavButtonView(iconName: "magazine", btnText: "Portfolio")
                FooterNavButtonView(iconName: "magnifyingglass", btnText: "Search")
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
            HStack {
                Image(systemName: iconName)
                    .font(.title)
                Text(btnText)
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(20)
        }
    }
}

struct StockSearchView: View {
    @State private var stockSymbol: String = ""
    var body: some View{
        VStack{
            /*
             Input "Enter Stock Symbol"
             Input Email
             Input PWord
             Input Addr
             Input City
             Input State
             Click Invest
             Click Cancel
             */
            HStack{
                Text("Stock Symbol:")
                TextField("", text: $stockSymbol).foregroundColor(.white).background(.gray).padding(0).cornerRadius(20).frame(width: 120, height: .infinity, alignment: .topLeading).font(.title).opacity(0.5)
            }
            
            Text("Stock Price: $123.45").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
            Text("Estimated Growth: 0.025%").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
            Text("Shareholders: 2.5 mil").foregroundColor(.white).frame(width: 300, height: 20, alignment: .topLeading)
            
            
        }.frame(width: 300, height: 300, alignment: .topLeading)
        
    }
}

struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView()
    }
}

