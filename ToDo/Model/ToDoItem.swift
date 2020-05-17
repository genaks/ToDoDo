//
//  ToDoItem.swift
//  ToDo
//
//  Created by Akshay Jain on 11/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import Foundation

struct ToDoItem : Equatable {
    
    let title : String
    let itemDescription : String?
    let timeStamp : Double?
    let location : Location?
    
    init(title: String, itemDescription: String? = nil, timeStamp : Double? = nil, location : Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timeStamp = timeStamp
        self.location = location
    }
}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    if lhs.location != rhs.location {
        return false
    }
    if lhs.timeStamp != rhs.timeStamp {
        return false
    }
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
    if lhs.title != rhs.title {
        return false
    }
    return true
}
