//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 11/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit_ShouldSetName() {
        let location = Location(name : "Location")
        
        XCTAssertEqual(location.name, "Location")
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let sampleCoordinate = CLLocationCoordinate2DMake(1, 2)
        let location = Location(name: "Location", coordinate: sampleCoordinate)
        
        XCTAssertEqual(sampleCoordinate.latitude, location.coordinate?.latitude)
        XCTAssertEqual(sampleCoordinate.longitude, location.coordinate?.longitude)
    }

}
