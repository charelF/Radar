//
//  ActivityListViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import MapKit

// UISearchController code from: https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started

class ActivityListViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let owner = ActivityOwner.allCases[searchBar.selectedScopeButtonIndex]
        filterActivities(for: searchBar.text!, owner: owner)
    }
    
    enum ActivityOwner: String, CaseIterable {
        case all = "All"
        case me = "Mine"
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 1: filterActivities(for: searchBar.text!, owner: .me)
        default: filterActivities(for: searchBar.text!, owner: .all)
        }
    }
    
    // filter the activities and put only the wanted activities in the local filteredActivities array
    func filterActivities(for query: String, owner: ActivityOwner) {
        
        // this nice code selects ALL activities where (AT LEAST ONE of the keywords contains part of the query)
        // AND (if the owner is all, then TRUE, else we check if the activity id matches the internal user id)
        
        filteredActivities = orderedActivities.filter { activity in
            return (activity.keyWords.contains { keyword in
                keyword.lowercased().contains(query.lowercased())
            }) && (owner == .all ? true : activity.creatorID == DataBase.data.user.id)
        }

        tableView.reloadData()
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        
        let searchBarScopeFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeFiltering)
    }
    
    
    var filteredActivities: [Activity] = []
    var orderedActivities: [Activity] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func retrieveAndSortActivities() -> [Activity] {
        let activities = DataBase.data.activities
        return activities.sorted { (a1, a2) -> Bool in
            a1.activityTime < a2.activityTime
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataBase.data.getActivities(completion: {
            self.orderedActivities = self.retrieveAndSortActivities()
            self.tableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for this to work, we need to set refreshing property in the Uitableviewcontroller in the storyboard to enabled
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        // for the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search activites"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // for the scope bar
        searchController.searchBar.scopeButtonTitles = ActivityOwner.allCases.map {$0.rawValue}
        searchController.searchBar.delegate = self
    }
    
    @objc func refresh(sender: AnyObject) {
        print("refresh called")
        DataBase.data.getActivities(completion: {
            self.orderedActivities = self.retrieveAndSortActivities()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            print("refresh finished")
        })
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredActivities.count : orderedActivities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        // we force cast the cell to be an object of type activity table view cell

        // Configure the cell... activity is either filterd or not, and found at indexPath.row
        let activity: Activity = isFiltering ? filteredActivities[indexPath.row] : orderedActivities[indexPath.row]
        
        cell.setActivity(activity: activity)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let receiver = segue.destination as? ActivityDetailViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        if segue.identifier == "showActivityFromList" {
            let activity: Activity = isFiltering ? filteredActivities[indexPath.row] : orderedActivities[indexPath.row]
            receiver.activity = activity
        }
    }

}


// this was the previous way of switching to the detail view controller
//    // the segue was simply from one VC to the detail VC.
//    // however there is a better way:
//    // In the storyboard, we connect the segue from the prototype cell to the detail view controller!
//    // that way we dont need the function below
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("the selected row is \(indexPath.row)")
//        tableView.deselectRow(at: indexPath, animated: false)
//        currentRow = indexPath.row
//        performSegue(withIdentifier: "showActivityFromList", sender: self)
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let receiver = segue.destination as? ActivityDetailViewController {
//            let activity = DataBase.data.activities[currentRow]
//            receiver.activity = activity
//        }
//    }
