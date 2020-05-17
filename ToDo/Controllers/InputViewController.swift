//
//  InputViewController.swift
//  ToDo
//
//  Created by Akshay Jain on 14/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet var titleTextField : UITextField!
    @IBOutlet var dateTextField : UITextField!
    @IBOutlet var locationTextField : UITextField!
    @IBOutlet var addressTextField : UITextField!
    @IBOutlet var descriptionTextField : UITextField!
    @IBOutlet var saveButton : UIButton!
    @IBOutlet var cancelButton : UIButton!

    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    @IBAction func save() {
        guard let titleString = titleTextField.text, titleString.count > 0 else { return }
        let date: Date?
        if let dateText = self.dateTextField.text, dateText.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        let descriptionString: String?
        if descriptionTextField.text!.count > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        if let locationName = locationTextField.text, locationName.count > 0 {
            if let address = addressTextField.text, address.count > 0 {
                        
                        geocoder.geocodeAddressString(address) {
                            [unowned self] (placeMarks, error) -> Void in
                            
                            let placeMark = placeMarks?.first
                            
                            let item = ToDoItem(title: titleString,
                                itemDescription: descriptionString,
                                timeStamp: date?.timeIntervalSince1970,
                                location: Location(name: locationName,
                                    coordinate: placeMark?.location?.coordinate))
                            
                            self.itemManager?.addToDoItem(item)
                        }
                }
        }
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
