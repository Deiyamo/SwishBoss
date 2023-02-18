//
//  DelivererWebService.swift
//  SwishBoss
//
//  Created by William Lin on 16/02/2023.
//

import Foundation

class DelivererWebService{
    class func getItems(completion: @escaping (Error?, [Deliverer]?) -> Void){
        
        guard let url = URL(string: "") else{
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
        
                let itemList = try JSONDecoder().decode(Playlists.self, from: d)
                
                completion(nil, itemList)
            } catch let err {
                completion(err, nil)
                return
            }
        }
        task.resume()
    }
    
}
