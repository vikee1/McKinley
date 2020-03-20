//
//  MDNetwrokManager.swift
//  McKinleyDemo
//
//  Created by Vikee Londhe on 20/03/20.
//  Copyright © 2020 Vikee Londhe. All rights reserved.
//

import UIKit

class MDNetwrokManager {
    
    static let shared = MDNetwrokManager()
    private init (){}
    
    func getDataRequest(urlStr: String, post: [String: String], completionBlock: @escaping ([String: Any], Error?) -> ()) {
        
        guard  let url = URL(string: urlStr) else { return }
        let postdata = (try? JSONSerialization.data(withJSONObject: post, options: []))
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = postdata
        urlRequest.allHTTPHeaderFields = getHTTPHeader()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let result = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("Response data string:\n \(result)")
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
    
    func getHTTPHeader() -> [String: String] {
        let headerDict = ["access-control-allow-headers": "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-methods": "GET, POST, PUT",
        "access-control-allow-origin":"*",
        "server": "cloudflare-nginx"]
        return headerDict
    }
}
