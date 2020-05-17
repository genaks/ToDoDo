//
//  KeychainAccessible.swift
//  ToDo
//
//  Created by Akshay Jain on 15/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
    func setPassword(password: String,
        account: String)
    
    func deletePasswortForAccount(account: String)
    
    func passwordForAccount(account: String) -> String?
}
