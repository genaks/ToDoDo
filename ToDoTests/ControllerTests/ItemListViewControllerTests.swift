//
//  ItemListViewControllerTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 12/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
    
    var sut : ItemListViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListViewController
        
        _ = sut.view //To trigger viewDidLoad
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.tableView!.dataSource)
        XCTAssertTrue(sut.tableView!.dataSource is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView!.delegate)
        XCTAssertTrue(sut.tableView!.delegate is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
        XCTAssertEqual(sut.tableView!.dataSource as? ItemListDataProvider,
                       sut.tableView!.delegate as? ItemListDataProvider)
    }
    
    func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController,
                       sut)
    }
    
    func testAddItem_PresentsAddItemViewController() {
        
        XCTAssertNil(sut.presentedViewController)
        
        guard let addButton = sut.navigationItem.rightBarButtonItem else
        { XCTFail(); return }
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSelector(onMainThread: addButton.action!, with: addButton, waitUntilDone: false)
        //sut.performSelector(inBackground: addButton.action!, with: addButton)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
    }
    
}
