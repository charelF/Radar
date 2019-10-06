//
//  Activity.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation

class Activity {

    let name: String
    let description: String
    
    let emoji: [String:String] =
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
    
    init(name: String, description: String, type: String) {
        self.name = name
        self.description = description
        self.type = type
    }
    
    
    
    
}

