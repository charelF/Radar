//
//  DataBase.swift
//  Radar
//
//  Created by Charel FELTEN on 16/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import MapKit
import Foundation
import KituraKit
import KituraContracts
import PromiseKit
/// if import error: add dependencies with File > Swift Packages > Add Package Dependency

/// kitura resources:
// https://developer.ibm.com/swift/2017/10/30/kiturakit-client-side-rest-made-easy/

/// more on the programming patterns encountered here: (completion handlers / closures)
// https://grokswift.com/completion-handlers-in-swift/
// https://grokswift.com/completion-handler-faqs/

/// more on promises:
// https://www.raywenderlich.com/9208-getting-started-with-promisekit
/// promises with completion handler
// https://github.com/mxcl/PromiseKit/issues/627#issuecomment-305372795

/// the main difficulty / problems seem to be: how to return data, as we dont know when we receive
/// the data (due to network), but can't stop the entire app while we wait for the data.
/// the best solution seems to be Promises, which we can implement with PromiseKit

/// with XCode 11.2, a strange bug errors occurs with PromiseKit:
// bug: https://github.com/mxcl/PromiseKit/issues/1099#issuecomment-548976601
// solution: https://stackoverflow.com/a/7313830/9439097


class DataBase {
    
    var activities: [String:Activity] = [:]
    
    // we have one user instance per app, which is stored in the DataBase singleton
    let user: User
    var client: KituraKit
    
    
    private init(){
        client = KituraKit(baseURL:"localhost:8081")!
        
        // check if its the first run
        let alreadyRun = UserDefaults.standard.bool(forKey: "alreadyRun")
        
        if alreadyRun {
            let userID = UserDefaults.standard.string(forKey: "userID")!
            self.user = User(id: userID)
        } else {
            self.user = User() // generate new user locally
            UserDefaults.standard.set(self.user.id, forKey: "userID")
            UserDefaults.standard.set(true, forKey: "alreadyRun")
        }
    }
    
    static let data = DataBase() // singleton
    
    func getActivitiesPromise() -> Promise<[Activity]> {
        // returns all activities on server, used for testing
        return Promise { seal in
            self.client.get("/activities") { (activitiyResponse: [Activity]?, error: RequestError?) -> Void in
                // either activities or error is nil, the other has a value
                guard let activities = activitiyResponse else {
                    return seal.reject(error!)
                }
                seal.fulfill(activities)
            }
        }
    }
    
    func getActivityPromise(_ activityID: String) -> Promise<Activity> {
        return Promise { seal in
            self.client.get("/activities", identifier: activityID) { (response: Activity?, error: RequestError?) -> Void in
                guard let activity = response else {
                    return seal.reject(error!)
                }
                seal.fulfill(activity)
            }
        }
    }
    
    func addActivity(_ activity: Activity) -> Promise<Activity> {
        return Promise { seal in
            self.client.put("/activities", identifier: activity.id, data: activity) {(activityResponse: Activity?, error:RequestError?) -> Void in
                guard let _ = activityResponse else {
                    return seal.reject(error!)
                }
                seal.fulfill(activityResponse!)
            }
        }
    }
    
    func updateActivity(_ activityID: String, completion: @escaping () -> Void) {
        firstly {
            getActivityPromise(activityID)
        }.done { activity in
            self.activities[activityID] = activity
            completion()
        }.catch { error in
            print(error)
        }
    }
    
    func getActivities(completion: @escaping () -> Void) {
        firstly {
            self.getActivitiesPromise()
        }.done { activities in
            // we now map [activity] to [activity.id:activity] for easier lookup
            self.activities = Dictionary(uniqueKeysWithValues: activities.map {
                ($0.id,$0) })
            completion()
        }.catch { error in
            print(error)
        }
    }
    
    // switches the participation status of the user for a given activity
    func switchActivityParticipation(for activityID: String, completion: @escaping () -> Void) {
        // we should also check that we are not the creator of the activity,
        // however this functionality is not yet implemted.
        
        let activity = activities[activityID]!
        var newActivity: Activity = activity
        
        if activity.participantIDs.contains(self.user.id) {
            // we do not want to participate anymore
            newActivity.participantIDs = activity.participantIDs.filter {$0 != self.user.id}
        } else {
            // we want to participate
            newActivity.participantIDs.append(self.user.id)
        }
        
        firstly {
            // we update (with HTTP PUT) the activity on the server, which sends back the updated version
            self.addActivity(newActivity)
        }.done { activity in
            // we update the activity in our activity list
            self.activities[activity.id] = activity
            completion()
        }.catch { error in
            print(error)
        }
    }
}
    
