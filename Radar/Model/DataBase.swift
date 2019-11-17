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
    
//    final let client = KituraKit(baseURL:"localhost:8080")
    
    static func getActivitiesTest() throws {
        if let client = KituraKit(baseURL:"localhost:8080") {
            client.get("/activities") { (activitiyResponse: [Activity]?, error: RequestError?) -> Void in
                guard let activities = activitiyResponse else {
                    //throw CustomRequestError.responseError
                    print("error")
                    return
                }
                print("fetched songs:")
                activities.forEach() { print($0) }
            }
        } else {
            throw CustomRequestError.urlError
        }
    }
    
    
    
    static func getActivities(near: CLLocationCoordinate2D, radius: Int = 10) {
        
    }
    
    static func getActivities(from: User, context: UserContext) {
        
    }
    
    static func getActivities() -> Promise<[Activity]> {
        // returns all activities on server, used for testing
        return Promise { seal in
//            guard let client = KituraKit(baseURL:"localhost:8080") else {
//                return seal.reject(CustomRequestError.urlError)
//            }
            let client = KituraKit(baseURL:"localhost:8080")! // force unwrap not ideal, redo
            
            client.get("/activities") { (activitiyResponse: [Activity]?, error: RequestError?) -> Void in
                guard let activities = activitiyResponse else {
                    // we know aR is nil thus we have an error
                    return seal.reject(error!) // we reject the seal with our error
                }
                // we know aR is not nil and we have no error
                // we can not return immediately as we dont know when the promise is fullfilled
                seal.fulfill(activities)
            }
        }
    }

    static func postActivity(activity: Activity) {
        
    }

}



