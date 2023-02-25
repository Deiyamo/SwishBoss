//
//  DelivererWebService.swift
//  SwishBoss
//
//  Created by William Lin on 16/02/2023.
//

import Foundation

class DelivererWebService{
    class func getItems(completion: @escaping (Error?, Deliverers?) -> Void){
    //
        guard let url = URL(string: "https://swish.ancelotow.com/api/v1/deliverer") else{
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
                let itemList = try JSONDecoder().decode(Deliverers.self, from: d)
                
                completion(nil, itemList)
            } catch let err {
                completion(err, nil)
                return
            }
        }
        task.resume()
    }
    
    class func createDeliverer(name: String, firstname: String, email: String, login: String, password: String, birthday: String, urlPhoto: Data,completion: @escaping (Error?, Bool?) -> Void){
        
        let attachments = [
                    AttachmentFile(fileDate: urlPhoto, key: "proof", filename: "proof.png")
                ]
        
        //https://swish.ancelotow.com/api/v1/deliverer
        guard let url = URL(string: "https://swish.ancelotow.com/api/v1/deliverer/") else{
            return
        }
        
        var request = URLRequest(url: url)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        // Set the content type header to multipart form data
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let filename = "example-image.jpg"
        let fieldName = "proof"
        // Create the request body
        var bodyData = Data()
        bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        bodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        bodyData.append(urlPhoto)
        bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
//        var body = URLComponents()
//        body.queryItems = [
//            URLQueryItem(name: "name", value: name),
//            URLQueryItem(name: "firstname", value: firstname),
//            URLQueryItem(name: "email", value: email),
//            URLQueryItem(name: "login", value: login),
//            URLQueryItem(name: "password", value: password),
//            URLQueryItem(name: "urlPhoto", value: urlPhoto),
//            URLQueryItem(name: "birthday", value: birthday)
//        ]
        let json: [String: Any] = ["name": name,
                                   "firstname": firstname,
                                   "email": email,
                                   "login": login,
                                   "password": password,
                                   "birthday": birthday ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else{
            return
        }
        
        bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; name=\"json\"\r\n".data(using: .utf8)!)
        bodyData.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        bodyData.append(jsonData)
        bodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Add the JSON data as a part of the request body
        
        request.httpBody = bodyData
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }
    
    class func deleteDeliverer(delivererUuid: String ,completion: @escaping (Error?, Any?) -> Void){
            
        let url = "https://swish.ancelotow.com/api/v1/deliverer/"+delivererUuid
        print(url)
        guard let getURL = URL(string: url) else{
            print("NOOOO")
            return
        }
        var request = URLRequest(url: getURL)
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "DELETE"
    
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }

            do {

                try JSONSerialization.jsonObject(with: d, options: .allowFragments)

                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }
        }
        task.resume()
    }
    
    class func modifyDeliverer(uuid: String, name: String, firstname: String, email: String, login: String, password: String, birthday: String, completion: @escaping (Error?, Bool?) -> Void){
        
        let url = "http://localhost:3000/deliverer/"+uuid
        
        guard let getURL = URL(string: url) else{
            return
        }
        var request = URLRequest(url: getURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var body = URLComponents()
        body.queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "firstname", value: firstname),
            URLQueryItem(name: "login", value: login),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "birthday", value: birthday),
            URLQueryItem(name: "urlPhoto", value: "https://res.cloudinary.com/dystym6wg/image/upload/v1657645756/upload_upoll/user/default_user_g6rfhq.jpg"),
            URLQueryItem(name: "email", value: email)
        ]
        let json: [String: Any] = ["name": name,
                                   "firstname": firstname,
                                   "email": email,
                                   "password": password,
                                   "birthday": birthday,
                                   "urlPhoto": "https://res.cloudinary.com/dystym6wg/image/upload/v1657645756/upload_upoll/user/default_user_g6rfhq.jpg",
                                   "login": login]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                print("non")
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            completion(nil, true)
        }
        task.resume()
    }
    
    
}
