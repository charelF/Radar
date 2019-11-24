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

// if above import create error, we need to add the dependencies.
// added dependencies with File > Swift Packages > Add Package Dependency
// and then I copy pasted the links from the Package.swift file in the RESTful music Client Demo


import MapKit

enum CustomRequestError: Error {
    case urlError
    case responseError
}

class DataBase {
    
//    let address: String = "192.168.178.116"
    let address: String = "localhost"
    let port: String = "8080"
    
    var activities: [Activity] = []
    var user: User? = nil
    let client: KituraKit
    
    private init(){
//        client = KituraKit(baseURL:"\(address):\(port)") ??
        client = KituraKit(baseURL:"localhost:8080")!
    }
    
    static let data = DataBase()
    
    static func getActivities(near: CLLocationCoordinate2D, radius: Int = 10) {
        
    }
    
    static func getActivities(from: User, context: UserContext) {
        
    }
    
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
    
    func getUserPromise(_ username: String) -> Promise<User> {
        print("we try to acces: /user?username=\(username)")
        // returns all activities on server, used for testing
        return Promise { seal in
            self.client.get("/user?username=\(username)") { (response: User?, error: RequestError?) -> Void in
                guard let user = response else {
                    return seal.reject(error!)
                }
                seal.fulfill(user)
            }
        }
    }
    
    // using this kind of escaping completion seems to be the way to go to do it.
    // inspiration: https://github.com/mxcl/PromiseKit/issues/627#issuecomment-305372795
    func getActivities(completion: @escaping () -> Void) {
        firstly {
            self.getActivitiesPromise()
        }.done { activities in
            print("just retrieved \(activities.count) activities from the server")
            self.activities = activities
            completion() // will execute the passed function/closure
        }.catch { error in
            print(error)
        }
    }
    
    func addActivity(_ activity: Activity) {
        self.client.put("/activities", identifier: activity.id, data: activity) {(activityResponse: Activity?, error:RequestError?) -> Void in
            guard let _ = activityResponse else {
                print("Error while adding activity: \(String(describing: error))")
                return
            }
            print("succesfully added activity")
        }
    }
    
    
    func login(username: String, completion: @escaping (Bool) -> Void) {
        
        firstly {
            self.getUserPromise(username)
        }.done{ user in
            
            // once the user has logged in, we need to remember this
            // and not ask again in the future.
            // methods to make data persistent in iOS:
            // https://medium.com/@imranjutt/data-persistence-in-ios-2804d04bde62
            // here we use UserDefaults, as it is enough for our case
            // https://learnappmaking.com/userdefaults-swift-setting-getting-data-how-to/
            
            UserDefaults.standard.set(user.id, forKey: "userID")
            UserDefaults.standard.set(true, forKey: "loggedIn")
            
            self.user = user
            
            completion(true)
            
        }.catch { error in
            print(error)
            completion(false)
        }
        
        
        return
        
        
    }
    
//    func participateInActivity(_ activity: Activity) {
//        if !(activity.participants.contains(User.user.id)) && activity.creatorID != User.user.id {
//            self.client.put("/activity/participate", identifier: User.user.id, data: activity) {(activityResponse: Activity?, error:RequestError?) -> Void in
//            guard let _ = activityResponse else {
//                print("Error while adding activity: \(String(describing: error))")
//                return
//            }
//            print("succesfully added activity")
//        }
//    }
//    }
    

}



