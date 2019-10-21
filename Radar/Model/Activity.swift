//
//  Activity.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import MapKit

// activity has to be a class because of the limitations and inheritance, but maybe one way of doing it is to create a new class called ActivityAnnotation that
// contains an Activity? not sure...
class Activity: NSObject, MKAnnotation {
    
    // activity adopts to these two protocols for it to be displayable on the map
    // this requires the following properties: title, subtitle, coordinate
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    
    let name: String
    let desc: String
    let emoji: String
    let domain: String
    let type: String
    
    let creationTime: Date
    let activityTime: Date
    
    let id: UUID
    
    let emojiDictionary: [String:[String:String]] =
        ["sport":
            ["bike":"🚴",
             "mountainbike":"🚵",
             "soccer":"⚽"],
         "games":
            ["videogame":"🎮",
             "boardgame":"🎲"],
         "social":
            ["drinks":"🍺"]
        ]
    
    
    
    init(name: String,
         desc: String,
         domain: String,
         type: String,
         coordinate: CLLocationCoordinate2D,
         activityTime: Date) {
        
        //super.init() //not sure if necessary
        
        self.name = name
        self.desc = desc
        self.domain = domain
        self.type = type
        self.emoji = emojiDictionary[self.domain]?[self.type] ?? "❌"
        
        self.title = name
        self.subtitle = desc
        self.coordinate = coordinate
        
        self.id = UUID()
        
        self.activityTime = activityTime
        self.creationTime = Date()
        
    }
    
}
