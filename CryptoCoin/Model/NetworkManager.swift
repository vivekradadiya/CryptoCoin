//
//  NetworkManager.swift
//  CryptoCoin
//
//  Created by Vivek Radadiya on 30/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var rate: String? = ""
    @Published var code: String? = ""
    
    let baseURL = "https://api.coindesk.com/v1/bpi/currentprice/"
    
    func getCryptoCurrencyRateFor(currency code: String) {
        
        let url = URL(string: "\(baseURL)\(code).json")
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url!) { (data, response, error) in
            
            if (error != nil) {
                print("Error : \(error?.localizedDescription ?? "")")
                return
            } else {
                
                if let safeData = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        guard let jsonDic = jsonResponse as? [String: Any] else {
                              return
                        }
                        if let bpi = jsonDic["bpi"] as? [String:Any] {
                            if let usd = bpi["\(code)"] as? [String:Any] {
                                DispatchQueue.main.async {
                                    self.rate = String(format: "%.2f", usd["rate_float"] as! Double)
                                    self.code = code
                                }
                            }
                        }
                    } catch let parsingError {
                        print("Error : \(parsingError.localizedDescription)")
                        return
                    }
                }
                
            }
            
        }
        task.resume()
        
    }
    
}
