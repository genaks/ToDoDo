//
//  APIClient.swift
//  ToDo
//
//  Created by Akshay Jain on 13/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import Foundation

class APIClient {
    
    enum WebserviceError : Error {
        case DataEmptyError
    }
    
    lazy var session: ToDoURLSession = URLSession.shared
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        guard let expectedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }
        guard let expectedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }

        guard let url = URL(string: "https://awesometodos.com/login?username=\(expectedUsername)&password=\(expectedPassword)") else
        {
            fatalError()
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(NSError(domain: "", code: 404, userInfo: [:]) as Error)
                return
            }
            if let responseData = data {
                do {
                    let responseDict = try JSONSerialization.jsonObject(with: responseData,
                                                                        options: []) as! Dictionary<String, String>
                    let token = responseDict["token"]! as String
                    self.keychainManager?.setPassword(password: token,
                        account: "token")
                } catch {
                    completion(error)
                }
            }
            else {
                completion(NSError(domain: "", code: 401, userInfo: [:]) as Error)
            }

        }
        task.resume()
    }
}

protocol ToDoURLSession {
    func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession : ToDoURLSession {
    
}
