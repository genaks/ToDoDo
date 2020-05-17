//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 11/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit_ShouldSetTitle() {
        let item = ToDoItem(title : "Title")
        XCTAssertEqual(item.title, "Title")
    }
    
    func testInit_ShouldSetTitleAndDescription() {
        let item = ToDoItem(title : "Title", itemDescription : "Description")
        XCTAssertEqual(item.itemDescription, "Description")
    }
    
    func testInit_ShouldSetTileDescriptionAndTimeStamp() {
        let item = ToDoItem(title : "Title", itemDescription : "Description", timeStamp : 0.0)
        XCTAssertEqual(item.timeStamp, 0.0)
    }
    
    func testInit_ShouldSetTitleDescriptionTimeStampAndLocation() {
        let location = Location(name : "Test Location")
        let item = ToDoItem(title : "Title", itemDescription : "Description", timeStamp : 0.0, location : location)
        
        XCTAssertEqual(location.name, item.location?.name)
    }

}
