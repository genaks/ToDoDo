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
    
    lazy var session: ToDoURLSession = URLSession.shared    //1 with URLSession and 4. change to ToDoURLSession
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(username: String, password: String, completion: @escaping (Error?) -> Void) {    //5
        
        guard let expectedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }
        guard let expectedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }

        //6 add the guard statement and 7 add the URL
        //8 add the parameters
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

protocol ToDoURLSession {   //2
    func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession : ToDoURLSession { //3
    
}
