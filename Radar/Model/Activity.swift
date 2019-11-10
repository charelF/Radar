//
//  Activity.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import MapKit

class ActivityWrapper: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let activity: Activity
    let title: String?
    let subtitle: String?
    
    init(activity: Activity) {
        self.activity = activity
        self.title = activity.name
        self.coordinate = activity.coordinate
        self.subtitle = activity.desc
    }
}


struct Activity: Identifiable, Codable {
    
    let name: String
    let desc: String
    
    let subcategory: Subcategory
    let category: Category
    let emoji: String
    
    private var customCoordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(customCoordinate)
        }
        set {
            customCoordinate = Coordinate(newValue)
        }
    }
    
    let creationTime: Date = Date()
    let activityTime: Date
    
    let id: UUID = UUID()
    
    var comments: [Comment] = []
    var participants: [User] = []
    //let creator: User
    
    init(name: String, desc: String, subcategory: Subcategory,
         coordinate: CLLocationCoordinate2D, activityTime: Date) {
        self.name = name
        self.desc = desc
        
        self.subcategory = subcategory
        self.category = subcategory.category
        self.emoji = subcategory.emoji
        
        self.customCoordinate = Coordinate(coordinate)
        
        self.activityTime = activityTime
    }
}

struct Coordinate: Codable, Hashable {
    // custom coordinate class to make it codable:
    // https://www.objc.io/blog/2018/10/23/custom-types-for-codable/
    let lat, long: Double
    
    init(_ coordinate: CLLocationCoordinate2D) {
        lat = coordinate.latitude
        long = coordinate.longitude
    }
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.long)
    }
}





struct Comment: Codable {
    let user: User
    let content: String
    let id: String = UUID().uuidString
}

class User: Codable {
    //let username: String
    let id: String = UUID().uuidString
    
    private init(){}
    static let user = User()
}


enum Category: String, Codable {
    case sport = "Sport"
    case game = "Game"
}


enum Subcategory: String, Codable {
    case soccer = "Soccer"
    case basketball = "Basketball"
    case tennis = "Tennis"
    
    case videogame = "Videogame"
    case boardgame = "Boardgame"
    
    var category: Category {
        switch self {
        case .soccer, .basketball, .tennis:
            return .sport
        case .videogame, .boardgame:
            return .game
        }
    }
    
    var emoji: String {
        switch self {
        case .soccer: return "⚽️"
        case .basketball: return "🏀"
        case .tennis: return "🥎"
        
        case .videogame: return "🎮"
        case .boardgame: return "🎲"
        }
    }
}





let testData: [Activity] = [
    Activity(name: "dungeons and dragons",
             desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description",
             subcategory: .boardgame,
             coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935),
             activityTime: Date()
    ),
    
    Activity(name: "Fussbal match",
             desc: "fussbal match zu cruchten",
             subcategory: .soccer,
             coordinate: CLLocationCoordinate2D(latitude: 49.621622, longitude: 6.161935),
             activityTime: Date()
    )
]
