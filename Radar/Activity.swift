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
         "mountainbike":"🚵",
         "soccer":"⚽",
         "drinks":"🍺"
    ]
    
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
            Activity(name: "Soccer practice", desc: "hi, we want to play some casual football matches and are looking for some volunteers to join us! ", type: "soccer", coordinate: CLLocationCoordinate2D(latitude: 49.691622, longitude: 6.211935)),
            Activity(name: "dungeons and dragons", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "boardgame", coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935)),
            Activity(name: "lan party", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "videogame", coordinate: CLLocationCoordinate2D(latitude: 49.831622, longitude: 6.071935)),
            Activity(name: "mtb treffen", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "mountainbike", coordinate: CLLocationCoordinate2D(latitude: 49.431622, longitude: 6.191935)),
            Activity(name: "drinks @ fabrik", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "drinks", coordinate: CLLocationCoordinate2D(latitude: 49.531622, longitude: 6.371935))
        ]
    }
    
    
    
    
}
