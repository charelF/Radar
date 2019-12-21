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
    
    var filteredActivities: [Activity] = []
    var orderedActivities: [Activity] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataBase.data.getActivities(completion: {
            self.orderedActivities = self.retrieveAndSortActivities()
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding pull down to refresh - requires setting refreshing property
        // in the Uitableviewcontroller in the storyboard to enabled
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        // for the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search activites"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // for the scope bar
        searchController.searchBar.scopeButtonTitles = ActivityContext.allCases.map {$0.rawValue}
        searchController.searchBar.delegate = self
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredActivities.count : orderedActivities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell

        // Configure the cell: activity is either shown or not depending on filter, and found at indexPath.row
        let activity: Activity = isFiltering ? filteredActivities[indexPath.row] : orderedActivities[indexPath.row]
        
        cell.setActivity(activity: activity)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let receiver = segue.destination as? ActivityDetailViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        if segue.identifier == "showActivityFromList" {
            let activity: Activity = isFiltering ? filteredActivities[indexPath.row] : orderedActivities[indexPath.row]
            // however the receiver will again receive just an id
            receiver.activityID = activity.id
        }
    }
    
    @objc func refresh(sender: AnyObject) {
        DataBase.data.getActivities(completion: {
            self.orderedActivities = self.retrieveAndSortActivities()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let owner = ActivityContext.allCases[searchBar.selectedScopeButtonIndex]
        filterActivities(for: searchBar.text!, owner: owner)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 1: filterActivities(for: searchBar.text!, owner: .me)
        default: filterActivities(for: searchBar.text!, owner: .all)
        }
    }
    
    // filters activites in place, updates filteredActivities array
    func filterActivities(for query: String, owner: ActivityContext) {
        
        filteredActivities = orderedActivities.filter { activity in
            
            // check if at least one of the keywords contains part of the query, or the query is empty, then we continue, otherwhise we return false
            guard (activity.keyWords.contains { (keyword) in
                keyword.lowercased().contains(query.lowercased())
            } || (query == "")) else {
                return false
            }
            
            // check the context of the activity
            switch owner {
            case .all:
                return true
            case .me:
                return (activity.creatorID == DataBase.data.user.id)
            case .participating:
                return (activity.participantIDs.contains(DataBase.data.user.id))
            }
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
    
    // retrieves [String:Activity] Dictionary from DataBase then transforms it into sorted [Activity] array
    // TODO: improve this so that we don't have to copy all the activities.
    func retrieveAndSortActivities() -> [Activity] {
        let activities = Array(DataBase.data.activities.values)
        return activities.sorted { (a1, a2) -> Bool in
            a1.activityTime < a2.activityTime
        }
    }
}


/// Notes to myself:
/// this was the previous way of switching to the detail view controller
/// the segue was simply from one VC to the detail VC, however there is a better way:
/// In the storyboard, we connect the segue from the prototype cell to the detail view controller!
/// that way we dont need the function below
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("the selected row is \(indexPath.row)")
//        tableView.deselectRow(at: indexPath, animated: false)
//        currentRow = indexPath.row
//        performSegue(withIdentifier: "showActivityFromList", sender: self)
//    }
