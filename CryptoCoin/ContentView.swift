//
//  ContentView.swift
//  CryptoCoin
//
//  Created by Vivek Radadiya on 30/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State var selectedCurrencyCode = 0
    
    let currencyCodeArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var body: some View {
        
        ZStack {
            
            Color(red: 85.0/255.0, green: 239.0/255.0, blue: 196.0/255.0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("CryptoCoin")
                    .font(Font.system(size: 40.0))
                    .foregroundColor(Color.black)
                    .padding(.top, 44.0)
                
                RoundedRectangle(cornerRadius: 40.0)
                    .frame(height: 80.0)
                    .padding().foregroundColor(Color.white)
                    .overlay(
                        
                        HStack {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 72.0, height: 72.0)
                                .padding(.leading, 20.0)
                            Spacer()
                            Text(networkManager.rate!)
                                .font(Font.system(size: 28.0))
                                .foregroundColor(Color.black)
                            Spacer()
                            Text(networkManager.code!)
                                .font(Font.system(size: 32.0))
                                .foregroundColor(Color.black)
                                .padding(.trailing, 40.0)
                            
                        }
                        
                )
                
                Spacer()
                
                Text("Please choose a currency")
                    .font(Font.system(size: 17.0))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 44.0)
                
                Picker(selection: $selectedCurrencyCode.onChange(fetchDataForCurruncyCode), label:
                    
                    Text("Please choose a currency")
                        .font(Font.system(size: 17.0))
                        .foregroundColor(Color.black)) {
                            
                            ForEach(0..<currencyCodeArray.count) {
                                Text(self.currencyCodeArray[$0])
                            }
                            
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(height: 100.0)
                .padding(.bottom, 100.0)
                
            }
            
        }
        
        .onAppear {
            self.networkManager.getCryptoCurrencyRateFor(currency: self.currencyCodeArray[self.selectedCurrencyCode])
        }
        
    }
    
    func fetchDataForCurruncyCode(_ tag: Int) {
        self.networkManager.getCryptoCurrencyRateFor(currency: self.currencyCodeArray[self.selectedCurrencyCode])
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11 Pro")
        }
    }
}


extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
