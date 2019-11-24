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
    
    var activities: [Activity] = []
    let client: KituraKit
    
    private init(){
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
    
    func getActivities() {
        firstly {
            self.getActivitiesPromise()
        }.done { activities in
            print("just retrieved \(activities.count) activities from the server")
            self.activities = activities
        }.catch { error in
            print(error)
        }
//        print("get activities called")
//        self.client.get("/activities") { (activitiyResponse: [Activity]?, error: RequestError?) -> Void in
//            // either activities or error is nil, the other has a value
//            guard let activities = activitiyResponse else {
//                return
//            }
//            print("activities added")
//            self.activities = activities
//        }
        
    }
    
    func addActivity(_ activity: Activity) {
        self.client.put("/activities", identifier: activity.id, data: activity) {(activityResponse: Activity?, error:RequestError?) -> Void in
            print(activityResponse, error)
            guard let _ = activityResponse else {
                print("Error while adding activity: \(error)")
                return
            }
            print("succesfully added activity")
            // we will reload our activites from the server
            self.getActivities()
        }
    }

}



