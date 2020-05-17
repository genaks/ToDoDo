//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 11/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class ItemManagerTests: XCTestCase {
    
    var sut : ItemManager!

    override func setUpWithError() throws {
        sut = ItemManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToDoCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func testDoneCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne() {
        sut.addToDoItem(ToDoItem(title: "First Task"))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func testShoulsReturnPreviouslyAddedItems() {
        let item = ToDoItem(title: "Item")
        sut.addToDoItem(item)
        
        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testCheckingItem_ChangesCountOfToDoAndDoneItems() {
        sut.addToDoItem(ToDoItem(title: "Item"))
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount, 0, "toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 1, "doneCount should be 1")
    }
    
    func testCheckingItem_RemovesItemFromToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        sut.addToDoItem(firstItem)
        sut.addToDoItem(secondItem)
        
        sut.checkItemAtIndex(0)

        XCTAssertEqual(sut.itemAtIndex(0).title, secondItem.title)
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "Item")
        sut.addToDoItem(item)
        sut.checkItemAtIndex(0)
        
        let returnedItem = sut.doneItemAtIndex(index: 0)
        XCTAssertEqual(item.title, returnedItem.title,
        "should be the same item")
    }
    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual() {
      let firstItem = ToDoItem(title: "First title",
          itemDescription: "First description",
          timeStamp: 0.0,
          location: Location(name: "Home"))
      let secondItem = ToDoItem(title: "First title",
          itemDescription: "First description",
          timeStamp: 0.0,
          location: Location(name: "Office"))
      
      XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testEqualLocations_ShouldBeEqual() {
      let firstLocation = Location(name: "Home")
      let secondLoacation = Location(name: "Home")
      
      XCTAssertEqual(firstLocation, secondLoacation)
    }
    
    func testWhenLatitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties (firstName: "Home",
            secondName: "Home",
            firstLongLat: (1.0, 0.0),
            secondLongLat: (0.0, 0.0))
    }
    
    func testWhenLongitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties (firstName: "Home",
            secondName: "Home",
            firstLongLat: (1.0, 0.0),
            secondLongLat: (0.0, 0.0))
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home",
            secondName: "Home",
            firstLongLat: (0.0, 0.0),
            secondLongLat: nil)
    }
    
    func testWhenNameDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home",
            secondName: "Office",
            firstLongLat: nil,
            secondLongLat: nil)
    }
    
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        var firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 0.0,
            location: nil)
        var secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 0.0,
            location: Location(name: "Office"))
        
        firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 0.0,
            location: Location(name: "Home"))
        secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 0.0,
            location: nil)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 1.0)
        let secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timeStamp: 0.0)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
            itemDescription: "First description")
        let secondItem = ToDoItem(title: "First title",
            itemDescription: "Second description")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title")
        let secondItem = ToDoItem(title: "Second title")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testRemoveAllItems_ShouldResultInCountsBeZero() {
        sut.addToDoItem(ToDoItem(title: "First"))
        sut.addToDoItem(ToDoItem(title: "Second"))
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.toDoCount, 1,
            "toDoCount should be 1")
        XCTAssertEqual(sut.doneCount, 1,
            "doneCount should be 1")
        
        sut.removeAllItems()
        XCTAssertEqual(sut.toDoCount, 0,
            "toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 0,
            "doneCount should be 0")
    }
    
    func testAddingTheSameItem_DoesNotIncreaseCount() {
        sut.addToDoItem(ToDoItem(title: "First"))
        sut.addToDoItem(ToDoItem(title: "First"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func performNotEqualTestWithLocationProperties(firstName: String,
        secondName: String,
        firstLongLat: (Double, Double)?,
        secondLongLat: (Double, Double)?,
        line: UInt = #line) {
            
            let firstCoord: CLLocationCoordinate2D?
            if let firstLongLat = firstLongLat {
                firstCoord = CLLocationCoordinate2D(
                    latitude: firstLongLat.0,
                    longitude: firstLongLat.1)
            } else {
                firstCoord = nil
            }
            let firstLocation = Location(name: firstName,
                coordinate: firstCoord)
            
            let secondCoord: CLLocationCoordinate2D?
            if let secondLongLat = secondLongLat {
                secondCoord = CLLocationCoordinate2D(
                    latitude: secondLongLat.0,
                    longitude: secondLongLat.1)
            } else {
                secondCoord = nil
            }
            let secondLocation = Location(name: secondName,
                coordinate: secondCoord)
            
            XCTAssertNotEqual(firstLocation, secondLocation, line:  line)
    }
}
