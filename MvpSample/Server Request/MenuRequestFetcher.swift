//
//  MenuRequestFetcher.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation

protocol MenuRequestProtocol {
    
    func onMenuReceived(details:[MenuDetailModel])
    
    func onErrorReceived(error: NSError)
    
}

class MenuRequestFetcher {
    
    static let url = "https://jsonplaceholder.typicode.com/posts"
    
    static func getDetails(requestProtocol : MenuRequestProtocol) {
        
        let url = URL(string: self.url)
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            guard let data = data, error == nil else {
                requestProtocol.onErrorReceived(error: NSError(domain: "101", code: 11, userInfo: nil))
                return
            }
            
            do {
                
                var menuDetails : [MenuDetailModel] = [MenuDetailModel]()
                
                let jsonArr = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                
                for jsonDict in jsonArr {
                    
                    let jsonDictData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
                    
                    guard let menuDetail = try? JSONDecoder().decode(MenuDetailModel.self, from: jsonDictData) else {
                        print("Couldn't decode menu detail")
                        requestProtocol.onErrorReceived(error: NSError(domain: "101", code: 11, userInfo: nil))
                        return
                    }
                    
                    // Save unique ids only
                    if !menuDetails.contains(menuDetail) {
                        menuDetails.append(menuDetail)
                    }
                }
                
                // Send request back
                requestProtocol.onMenuReceived(details: menuDetails)
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                requestProtocol.onErrorReceived(error: NSError(domain: "101", code: 11, userInfo: nil))
            }
            
            
        }
        
        task.resume()
    }
}
