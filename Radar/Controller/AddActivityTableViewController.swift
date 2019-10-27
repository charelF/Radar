//
//  AddActivityTableViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 21/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// picker view inspired by: https://stackoverflow.com/questions/45766436/swift-uipickerview-1st-component-changes-2nd-components-data?noredirect=1&lq=1

import UIKit
import CoreLocation

class AddActivityTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var typePicker: UIPickerView!
    var pickerData: [(String,[String])] = []
    var pickerValue: (String?,String?) = (nil,nil)
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextViewFixed!
    
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var timeSegment: UISegmentedControl!
    
    
    
    var mapCoordinates: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.typePicker.delegate = self
        self.typePicker.dataSource = self

        pickerData = [("sport",["bike", "run", "soccer", "basketball"]),
                      ("games",["videogame", "boardgame", "adventuregame"])]

        // not sure if necessary
        typePicker.reloadAllComponents()
        typePicker.selectRow(0, inComponent: 0, animated: false)

//        pickerData = [("sport",["bike", "run", "soccer"]),
//        ("games",["videogame", "boardgame", "adventuregame"])]
        
        loadSegments(forDay: "today")
        
    }
    
    func loadSegments(forDay day: String) {
        
        let possibleTimes: [String]
        
        switch day {
        case "today":
            possibleTimes = ActivityHandler.getPossibleTimesOfDay()
        default:
            possibleTimes = ["morning", "noon", "afternoon", "evening", "night"]
        }
        
        self.timeSegment.removeAllSegments()
        
        for i in 0..<possibleTimes.count {
            self.timeSegment.insertSegment(withTitle: possibleTimes[i], at: i, animated: true)
        }
    }
            
    
    // triggered when selecting day
    @IBAction func timesForDay(_ sender: Any) {
        
        switch dateSegment.selectedSegmentIndex {
        case 0: //today
            loadSegments(forDay: "today")
        default:
            loadSegments(forDay: "tomorrow")
        }
        
    }
    
    
    
    // number of columns in Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    // number of rows per column in Picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            //pickerView.reloadComponent(1)
            //pickerView.selectRow(0, inComponent: 1, animated: true)

            return pickerData.count
        } else {
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)
            return pickerData[selectedRowInFirstComponent].1.count
        }
    }

    // what to show for a specific row (row) and column (component)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            // refresh and reset 2nd component everytime another 1st component is chosen
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)

            // return the first value of the tuple (so the category name) at index row
            return pickerData[row].0
        } else {
            // component is 1, so we look which row is selected in the first component
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)

            return pickerData[selectedRowInFirstComponent].1[row]
        }
        //return pickerData[component].1[row]
    }

    // what to do for a specific selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)
            print(pickerData[selectedRowInFirstComponent].1[0]) // last subscript is 0, because we reset comp 2 to first element
            
            //pickerValue = pickerData[selectedRowInFirstComponent].1[0]
            pickerValue = (pickerData[selectedRowInFirstComponent].0, pickerData[selectedRowInFirstComponent].1[0])
        } else {
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)

            print(pickerData[selectedRowInFirstComponent].1[row])
            
            //pickerValue = pickerData[selectedRowInFirstComponent].1[row]
            pickerValue = (pickerData[selectedRowInFirstComponent].0, pickerData[selectedRowInFirstComponent].1[row])
        }
    }
    
    // how to display the pickerView
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var pickerLabel: UILabel? = (view as? UILabel)
//        if pickerLabel == nil {
//            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont.systemFont(ofSize: 20.0)
//        }
//
//        if component == 0 {
//            pickerLabel?.textAlignment = .right
//            pickerLabel?.text = (pickerLabel?.text ?? "none") + "         "
//        } else {
//            pickerLabel?.textAlignment = .left
//            pickerLabel?.text = "         " + (pickerLabel?.text ?? "none")
//        }
//
//
//        pickerLabel?.textColor = UIColor.red
//
//        return pickerLabel!
//    }

    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // to stylise the picke view: https://stackoverflow.com/questions/32026074/formatting-alignment-of-uipickerview
        
    @IBAction func save(_ sender: Any) {
        
        var date: String {
            switch dateSegment.selectedSegmentIndex {
                case 0: return "Today"
                case 1: return "Tomorrow"
                default: return "Today"
            }
        }
        
        var time: String {
            switch dateSegment.selectedSegmentIndex {
                case 0: return "Morning"
                case 1: return "Noon"
                case 2: return "Afternoon"
                case 3: return "Evening"
                case 4: return "Night"
                default: return "Morning"
            }
        }
        
        //print(date, time, pickerValue, titleField.text, descriptionField.text, mapCoordinates)
        
        // at this point, tell the user if some values are missing
        
        let name = titleField.text ?? "no name"
        let desc = descriptionField.text ?? "no description"
        let domain = pickerValue.0 ?? "no domain"
        let type = pickerValue.1 ?? "no type"
        let coordinates = mapCoordinates ?? CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935)
        ActivityHandler.instance.createActivity(name:  name, description: desc, domain: domain, type: type, time: time, date: date, coordinates: coordinates)
        
        
        print("activity was created")
        print(ActivityHandler.instance.activityList.count)
        
        // everything seems to work, just the map view controllers (and the others) are not updated
        // how do we update it?
        // 1) -> https://medium.com/livefront/why-isnt-viewwillappear-getting-called-d02417b00396
        // no real solution found, other than set the modal style to .fullscreen in storyboard, which will
        // call the viewWillAppear method of the mapviewcontroller
        
        
        dismiss(animated: true, completion: nil)
    }
    

    

}
