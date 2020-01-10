//
//  SettingsTableViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 16/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import PromiseKit

/// this view controller was used for debugging throughout the development of the project
class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username?.text = DataBase.data.user.id
    }
    
}
