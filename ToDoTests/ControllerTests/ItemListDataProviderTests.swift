//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 13/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUpWithError() throws {
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(identifier: "ItemListViewController")
        _ = controller.view
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfSectionsIsTwo() {
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testRowsInSectionCount_IsToDoCount() {
        sut.itemManager?.addToDoItem(ToDoItem(title: "FirstItem"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.addToDoItem(ToDoItem(title: "SecondItem"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberRowsInSecondSection_IsDoneCount() {
        sut.itemManager?.addToDoItem(ToDoItem(title: "First"))
        sut.itemManager?.addToDoItem(ToDoItem(title: "Second"))
        sut.itemManager?.checkItemAtIndex(0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRow_ReturnsItemCell() {
        
        sut.itemManager?.addToDoItem(ToDoItem(title: "First"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell() {
        let mockTableView = MockTableView()
        
        mockTableView.dataSource = sut
        mockTableView.register(ItemCell.self,
                               forCellReuseIdentifier: "ItemCell")
        sut.itemManager?.addToDoItem(ToDoItem(title: "First"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDeqeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        let toDoItem = ToDoItem(title: "First",
                                itemDescription: "First description")
        sut.itemManager?.addToDoItem(toDoItem)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(cell.toDoItem, toDoItem)
        
    }
    
    func testCellInSectionTwo_GetsConfiguredWithDoneItem() {
        
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        let firstItem = ToDoItem(title: "First",
                                 itemDescription: "First description")
        sut.itemManager?.addToDoItem(firstItem)
        
        let secondItem = ToDoItem(title: "Second",
                                  itemDescription: "Second description")
        sut.itemManager?.addToDoItem(secondItem)
        
        sut.itemManager?.checkItemAtIndex(1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, secondItem)
    }
        
}

extension ItemListDataProviderTests {
    class MockTableView : UITableView {
        class func mockTableViewWithDataSource(
            dataSource: UITableViewDataSource) -> MockTableView {
            
            let mockTableView = MockTableView(
                frame: CGRect(x: 0, y: 0, width: 320, height: 480),
                style: .plain)
            
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            return mockTableView
        }
        var cellGotDeqeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDeqeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockItemCell : ItemCell {

        var toDoItem: ToDoItem?

//        override func configCellWithItem(item: ToDoItem) {
//            toDoItem = item
//        }
    }
    
}
