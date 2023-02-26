//
//  APIRequest.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 25/02/2023.
//

import Foundation

class APIRequest {
    
    static let base = "https://swish.ancelotow.com/api/v1"
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6bnVsbCwidXVpZCI6bnVsbCwiaXNBZG1pbiI6dHJ1ZSwiaWF0IjoxNjc3MzY0Njg1LCJleHAiOjE2Nzc2MjM4ODV9._CBjdGwsxBsMZzaRXENqdX_GLOQI7IIDnkXcUEX3C44"
    
    
    class func get(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: base + url)!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        return request
    }
    
    
    
    
    class func post(url: String, body: Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: base + url)!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        request.httpBody = body
        
        return request
    }
    
    class func postWithMedia(url: String, body: Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: base + url)!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // multipart/form-data
        request.httpMethod = "POST"
        
        request.httpBody = body
        
        return request
    }
    
    
    
    
    
    class func put(url: String, body: Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: base + url)!)
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        request.httpBody = body
        
        return request
    }
    
    class func delete(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: base + url)!)
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        return request
    }
    
    
}
