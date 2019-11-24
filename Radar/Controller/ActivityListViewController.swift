//
//  ActivityListViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import MapKit

class ActivityListViewController: UITableViewController {
    
    var activities: [Activity] = []
    var currentRow: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activities = DataBase.data.activities // afterwards we will have to change this code:
        // the activities that are shown are retrieved from the server
    }
    
    override func viewDidLoad() {
        
        // for this to work, we need to set refreshing property in the Uitableviewcontroller in the storyboard to enabled
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func refresh(sender: AnyObject) {
        print("refresh called")
        DataBase.data.getActivities()
        activities = DataBase.data.activities
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        print("refresh finished")
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        // we force cast the cell to be an object of type activity table view cell

        // Configure the cell...
        let activity = activities[indexPath.row]
//        cell.textLabel?.text = activity.name
//        cell.detailTextLabel?.text = activity.description
        
        cell.setActivity(activity: activity)
        
        currentRow = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "showActivityFromList", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if let receiver = segue.destination as? ActivityDetailViewController {
            let activity = activities[currentRow]
            receiver.activity = activity
        }
    }

}
