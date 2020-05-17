//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Akshay Jain on 12/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet var tableView: UITableView?
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.dataSource = dataProvider
        tableView!.delegate = dataProvider
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItem(_ sender: Any) {
        present(InputViewController(),
        animated: true,
        completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
