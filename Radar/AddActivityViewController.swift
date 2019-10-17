//
//  AddActivityViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 17/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// picker view inspired by: https://stackoverflow.com/questions/45766436/swift-uipickerview-1st-component-changes-2nd-components-data?noredirect=1&lq=1


import UIKit

class AddActivityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var typePicker: UIPickerView!
    var pickerData: [(String,[String])] = []


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
            //pickerView.selectRow(0, inComponent: 1, animated: true)

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
        } else {
            let selectedRowInFirstComponent = pickerView.selectedRow(inComponent: 0)

            print(pickerData[selectedRowInFirstComponent].1[row])
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
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
