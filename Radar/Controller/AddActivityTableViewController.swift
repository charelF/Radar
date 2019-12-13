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
    var pickerData: [(Category,[Subcategory])] = []
    var pickerValue: (Category?,Subcategory?) = (nil,nil)
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextViewFixed!
    
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var timeSegment: UISegmentedControl!
    
    
    
    var mapCoordinates: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.typePicker.delegate = self
        self.typePicker.dataSource = self

        pickerData = Subcategory.getRelations()

        // not sure if necessary
        typePicker.reloadAllComponents()
        typePicker.selectRow(0, inComponent: 0, animated: false)

        loadSegments(forDay: .today)
        
    }
    
    func loadSegments(forDay day: PartOfWeek) {
        
        let possibleTimes: [PartOfDay]
        
        switch day {
        case .today:
            possibleTimes = Time.getPossibleTimesOfDay()
        default:
            possibleTimes = PartOfDay.allCases
        }
        
        self.timeSegment.removeAllSegments()
        
        for i in 0..<possibleTimes.count {
            self.timeSegment.insertSegment(withTitle: possibleTimes[i].rawValue, at: i, animated: true)
        }
    }
            
    
    // triggered when selecting day
    @IBAction func timesForDay(_ sender: Any) {
        
        switch dateSegment.selectedSegmentIndex {
        case 0: //today
            loadSegments(forDay: .today)
        default:
            loadSegments(forDay: .tomorrow)
        }
        
    }
    
//    @IBAction func debugSegmentedIndex(_ sender: Any) {
//        
//        print("number of segments", timeSegment.numberOfSegments)
//        print("selected segment", timeSegment.selectedSegmentIndex)
//        print("title", timeSegment.titleForSegment(at: timeSegment.selectedSegmentIndex))
//    }
    
    
    // number of columns in Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    // number of rows per column in Picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
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
            return pickerData[row].0.rawValue
        } else {
            // component is 1, so we look which row is selected in the first component
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)

            return pickerData[selectedRowInFirstComponent].1[row].rawValue
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
            
            pickerValue = (pickerData[selectedRowInFirstComponent].0, pickerData[selectedRowInFirstComponent].1[0])
        } else {
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)

            print(pickerData[selectedRowInFirstComponent].1[row])
            
            //pickerValue = pickerData[selectedRowInFirstComponent].1[row]
            pickerValue = (pickerData[selectedRowInFirstComponent].0, pickerData[selectedRowInFirstComponent].1[row])
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // to customise the picke view: https://stackoverflow.com/questions/32026074/formatting-alignment-of-uipickerview
        
    @IBAction func save(_ sender: Any) {
        
        var partOfWeek: PartOfWeek {
            switch dateSegment.selectedSegmentIndex {
            case 0: return .today
            case 1: return .tomorrow
            default: return .today
            }
        }
        
        print(dateSegment.numberOfSegments)
        print(dateSegment.selectedSegmentIndex)
        //print(dateSegment.numberOfSegments - dateSegment.selectedSegmentIndex)
        
        var partOfDay: PartOfDay {
            switch (timeSegment.numberOfSegments - timeSegment.selectedSegmentIndex) {
            case 5: return .morning
            case 4: return .noon
            case 3: return .afternoon
            case 2: return .evening
            case 1: return .night
            default: return .morning
            }
        }
        
        // TODO: validate these inputs, if they are nil, prompt user with warning
        let name = titleField.text ?? "NONAME"
        let desc = descriptionField.text ?? "NODESCRIPTION"
        let subcategory = pickerValue.1 ?? .tennis
        let coordinates = mapCoordinates!
        
        
        let activity = Activity(name: name, desc: desc, subcategory: subcategory, coordinate: coordinates,
                                activityTime: Time.timeTupleToDate(partOfWeek: partOfWeek, partOfDay: partOfDay),
                                creatorID: DataBase.data.user.id)
        
        _ = DataBase.data.addActivity(activity)
        
        dismiss(animated: true, completion: nil)
    }
    

    

}
