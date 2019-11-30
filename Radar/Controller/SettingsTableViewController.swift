//
//  SettingsTableViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 16/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import PromiseKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    
    @IBAction func testServerConnection(_ sender: Any) {
        
    }
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id?.text = DataBase.data.user.id
    }
    
}
