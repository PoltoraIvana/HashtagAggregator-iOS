//
//  ApiManager.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiClient {
    
    static let shared = ApiClient()
    
    private static let mainUrl = "http://hashtagaggregator.azurewebsites.net/api/statistics/"
    
    let sharedSession = URLSession(configuration: .default)
    
    private func get(request: URLRequest, completion: @escaping (Bool, Any?) -> ()) {
        dataTask(with: request, method: "GET", completion: completion)
    }
    
    private func dataTask(with request: URLRequest, method: String, completion: @escaping (Bool, Any?) -> ()) {
        var request = request
        request.httpMethod = method
        
        let session = sharedSession
        
        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        completion(true, json)
                    } else {
                        completion(false, json)
                    }
                }
            }
        }
        .resume()
    }
    
    private func clientURLRequest(path: String, parameters: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        var request = URLRequest(url: URL(string: ApiClient.mainUrl + path)!)
        
        if let parameters = parameters {
            var paramString = ""
            for (key, value) in parameters {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.string?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
            
            request.setValue("application/url-encoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: .utf8)
        }

        return request
    }
    
    func getMesages(for hashtag: String, completion: @escaping (Bool, [Message]?) -> ()) {
        get(request: clientURLRequest(path: hashtag)) { success, json -> Void in
            DispatchQueue.main.async {
                if success {
                    if let json = json {
                        if let messages = Mapper<Message>().mapArray(JSONObject: json) {
                            completion(success, messages)
                        }
                    }
                }
                completion(success, nil)
            }
        }
    }
}
