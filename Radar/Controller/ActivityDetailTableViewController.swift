//
//  ActivityDetailTableViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 04/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class ActivityDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.register(ActivityDetailTableViewCell.self, forCellReuseIdentifier: "activity")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 10
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400
        }
        return tableView.rowHeight
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "activity", for: indexPath)
            let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
            let activityView = views?[0] as! ActivityView
            cell.addSubview(activityView)
            activityView.center = cell.convert(cell.center, from: cell.superview)
            
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: "participate", for: indexPath)
        case 2: cell = tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        default: cell = tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
