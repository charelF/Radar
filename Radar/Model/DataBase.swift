//
//  DataBase.swift
//  Radar
//
//  Created by Charel FELTEN on 16/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// kitura resources:
// https://developer.ibm.com/swift/2017/10/30/kiturakit-client-side-rest-made-easy/

// more on the programming patterns encountered here: (completion handlers / closures)
// https://grokswift.com/completion-handlers-in-swift/
// https://grokswift.com/completion-handler-faqs/

// more on promises:
// https://www.raywenderlich.com/9208-getting-started-with-promisekit

// the main difficulty / problems seem to be: how to return data, as we dont know when we receive
// the data (due to network), but can't stop the entire app while we wait for the data.
// the best solutions seems to be Promises, which we can implement with PromiseKit

import Foundation
import KituraKit
import KituraContracts
import PromiseKit
// with XCode 11.2, a strange bug errors occurs with PromiseKit:
// solution:
// 1) what: https://github.com/mxcl/PromiseKit/issues/1099#issuecomment-548976601
// 2) how: https://stackoverflow.com/a/7313830/9439097


// if above import create error, we need to add the dependencies.
// added dependencies with File > Swift Packages > Add Package Dependency
// and then I copy pasted the links from the Package.swift file in the RESTful music Client Demo


import MapKit

class DataBase {
    
//    let address: String = "192.168.178.116"
    let address: String = "localhost"
    let port: String = "8080"
    
    //var activities: [Activity] = []
    
    var activities: [String:Activity] = [:]
    
    let user: User
    var client: KituraKit
    
    
    private init(){
        client = KituraKit(baseURL:"\(address):\(port)")!
        
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
    static let data = DataBase()
    
    
    
    func getActivitiesPromise() -> Promise<[Activity]> {
        // returns all activities on server, used for testing
        return Promise { seal in
            self.client.get("/activity") { (activitiyResponse: [Activity]?, error: RequestError?) -> Void in
                // either activities or error is nil, the other has a value
                guard let activities = activitiyResponse else {
                    return seal.reject(error!)
                }
                seal.fulfill(activities)
            }
        }
    }
    
//    func getUserPromise(_ username: String) -> Promise<User> {
//        print("we try to acces: /user?username=\(username)")
//        // returns all activities on server, used for testing
//        return Promise { seal in
//            let q = Query(username: username)
//            self.client.get("/user", query: q) { (response: User?, error: RequestError?) -> Void in
//                guard let user = response else {
//                    return seal.reject(error!)
//                }
//                seal.fulfill(user)
//            }
//        }
//    }
    
    // using this kind of escaping completion seems to be the way to go to do it.
    // inspiration: https://github.com/mxcl/PromiseKit/issues/627#issuecomment-305372795
    func getActivities(completion: @escaping () -> Void) {
        firstly {
            self.getActivitiesPromise()
        }.done { activities in
            print("just retrieved \(activities.count) activities from the server")
            // we now map [activity] to [activity.id:activity] for easier lookup
            // we first transform it via map into an array of tuples, and then
            // we transform the array into a dictionary.
            self.activities = Dictionary(uniqueKeysWithValues: activities.map {
                ($0.id,$0) })
            completion() // will execute the passed function/closure
        }.catch { error in
            print(error)
        }
    }
    
    func addActivity(_ activity: Activity) -> Promise<Activity> {
        return Promise { seal in
            self.client.put("/activity", identifier: activity.id, data: activity) {(activityResponse: Activity?, error:RequestError?) -> Void in
                guard let _ = activityResponse else {
                    print("Error while adding activity: \(String(describing: error))")
                    return seal.reject(error!)
                }
                print("succesfully added activity")
                seal.fulfill(activityResponse!)
            }
        }
    }
    
    func switchActivityParticipation(for activityID: String, completion: @escaping () -> Void) {
        // currently the only operation that modifies an activity
        
        // only thing to watch out is that we are not the creator
        // however for this prototype we wont check this as there are currently no other
        // users so this check will cause troubles...
        
        var newActivity: Activity = activities[]
        
        if activity.participantIDs.contains(self.user.id) {
            // we do not want to participate anymore
            print("unparticipate")
            newActivity.participantIDs = activity.participantIDs.filter {$0 != self.user.id}
        } else {
            print("participate")
            // we want to participate
            newActivity.participantIDs.append(self.user.id)
        }
        
        // in any case, the addActivity method will PUT (update) the currently existing activity with this new one
        print(newActivity.participantIDs.count)
        
        firstly {
            self.addActivity(newActivity)
        }.done { activity in
            completion(activity) // we let the caller know whether the change he did
            // was executed succesfully, in any case the caller gets the same activity
            // as the one that is now on the server
        }.catch { _ in 
            print("error")
        }
        
    }
}
    






    
//    func createUser()
    
    
//    func login(username: String, completion: @escaping (Bool) -> Void) {
//
//        print(UserDefaults.standard.bool(forKey: "loggedIn"))
//        //UserDefaults.standard.set(true, forKey: "loggedIn")
////
////        firstly {
////            self.getUserPromise(username)
////        }.done{ user in
////
////            // once the user has logged in, we need to remember this
////            // and not ask again in the future.
////            // methods to make data persistent in iOS:
////            // https://medium.com/@imranjutt/data-persistence-in-ios-2804d04bde62
////            // here we use UserDefaults, as it is enough for our case
////            // https://learnappmaking.com/userdefaults-swift-setting-getting-data-how-to/
////
////            UserDefaults.standard.set(user.id, forKey: "userID")
////            UserDefaults.standard.set(true, forKey: "loggedIn")
////
////            self.user = user
////
//            completion(true)
////
////        }.catch { error in
////            print(error)
////            completion(false)
////        }
//
//
//        return
//
//
//    }
    
    




