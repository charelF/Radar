//
//  Activity.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import MapKit

class Activity: NSObject, MKAnnotation {
    
    // activity adopts to these two protocols for it to be displayable on the map
    // this requires the following properties: title, subtitle, coordinate
    
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    let name: String
    let desc: String
    
    let emoji: String
    
    let emojiDictionary: [String:String] =
        ["bike":"🚴",
         "videogame":"🎮",
         "boardgame":"🎲",
         "mountainbike":"🚵"]
    
    let type: String
    
    // is called like this: to get an emoji: emoji[activity.type] --> returns the bike emoji
    

//    let languages: [String] // also display with emojis
//
//    let type: String
//    let information: [String:Any]
//
//    let ID: Int
//    let userID: Int
//
//    let lat: Double
//    let long: Double
//
//    let creationTime: Double
//    let activityTime: Double
    
//
//    init(name: String,
//         description: String,
//         languages: [String:Any],
//         type: String,
//         information: [String:Any],
//        ) {
//        <#statements#>
//    }
    
    init(name: String,
         desc: String,
         type: String,
         coordinate: CLLocationCoordinate2D) {
        
        self.name = name
        self.desc = desc
        self.type = type
        // investigate why this is necessary, I have really no idea why swift sees
        // the dictionary as an optional...
        self.emoji = emojiDictionary[self.type] ?? "❌"
        
        
        self.title = name
        self.subtitle = desc
        self.coordinate = coordinate
        
        super.init() //not sure if necessary
    }
    
    
    // just for test purposes
    static func testActivities() -> [Activity] {
        return [
            Activity(name: "activity 1", desc: "description 1", type: "bike", coordinate: CLLocationCoordinate2D(latitude: 49.691622, longitude: 6.211935)),
            Activity(name: "activity 5 luxb", desc: "description 5", type: "mountainbike", coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935))
        ]
    }
    
    
    
    
}
