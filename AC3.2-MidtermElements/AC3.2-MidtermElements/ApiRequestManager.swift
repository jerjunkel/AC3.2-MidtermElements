//
//  ApiRequestManager.swift
//  AC3.2-MidtermElements
//
//  Created by Jermaine Kelly on 12/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

enum RequestMethod: String{
    case post = "POST"
    case get = "GET"
}

public let elementsEndpoint: String = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"

class ApiRequestManager{
    static let manager: ApiRequestManager = ApiRequestManager()
    private init(){}
    
    let session: URLSession = URLSession(configuration: .default)
    
    func makeRequest(to endpoint: String, method: RequestMethod = .get, body: Data? = nil, completion: @escaping (Data?)->Void){
        guard let url: URL = URL(string: endpoint) else { return }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        switch method{
        case .get:
            //print("get method")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        case .post:
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // this is specifically for the midterm  -- don't change if you want to write there
            request.addValue("Basic a2V5LTE6dHdwTFZPdm5IbEc2ajFBZndKOWI=", forHTTPHeaderField: "Authorization")
            request.httpBody = body
        }
        
        session.dataTask(with: request) { (data: Data?, response:URLResponse?, error:Error?) in
            if error != nil {
                print("Error encountered during post request: \(error)")
            }
            if response != nil {
                let httpResponse = (response! as! HTTPURLResponse)
                print("Response status code: \(httpResponse.statusCode)")
            }
            completion(data)
            
            }.resume()
    }
    
    func makeHTTPBody(dict: [String:Any])->Data?{
        do{
            let body = try JSONSerialization.data(withJSONObject: dict, options: [])
            return body
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}


