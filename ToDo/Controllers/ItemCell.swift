//
//  ItemCell.swift
//  ToDo
//
//  Created by Akshay Jain on 13/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    func configCellWithItem(item: ToDoItem,
        checked: Bool = false) {
            
            if checked {
                let attributedTitle = NSAttributedString(string: item.title,
                                                         attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                
                titleLabel.attributedText = attributedTitle
                locationLabel.text = nil
                dateLabel.text = nil
            } else {
                titleLabel.text = item.title
                locationLabel.text = item.location?.name
                
                if let timestamp = item.timeStamp {
                    let date = Date(timeIntervalSince1970: timestamp)
                    
                    dateLabel.text = dateFormatter.string(from: date)
                }
            }
    }
}
