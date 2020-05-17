//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 14/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main",
            bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController
        _ = sut.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        
        let itemManager = ItemManager()
        itemManager.addToDoItem(ToDoItem(title: "The title",
            itemDescription: "The description",
            timeStamp: 1456150025,
            location: Location(name: "Home", coordinate: coordinate)))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()

        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqual(sut.descriptionLabel.text, "The description")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude,
            coordinate.latitude,
            accuracy: 0.001)
    }
    
    func testCheckItem_ChecksItemInItemManager() {
        
        let itemManager = ItemManager()
        itemManager.addToDoItem(ToDoItem(title: "The title"))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
    
}
