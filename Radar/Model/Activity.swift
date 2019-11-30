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
    
    init(_ activity: Activity) {
        self.activity = activity
        self.title = activity.name
        self.coordinate = activity.coordinate
        self.subtitle = activity.desc
    }
    
    static func wrap(for activities: [Activity]) -> [ActivityWrapper] {
        var activityWrapper: [ActivityWrapper] = []
        for activity in activities {
            activityWrapper.append(ActivityWrapper(activity))
        }
        return activityWrapper
    }
            
}


struct Activity: Identifiable, Codable, Equatable {
    
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
    
    let id: String = UUID().uuidString
    
    var participantIDs: [String] = []
    let creatorID: String
    
    init(name: String, desc: String, subcategory: Subcategory,
         coordinate: CLLocationCoordinate2D, activityTime: Date,
         creatorID: String) {
        
        self.name = name
        self.desc = desc
        
        self.subcategory = subcategory
        self.category = subcategory.category
        self.emoji = subcategory.emoji
        
        self.customCoordinate = Coordinate(coordinate)
        
        self.activityTime = activityTime
        
        self.creatorID = creatorID
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}

// activity can now be encoded and decoded like this:
// activity -> JSON
//let jsonData = try! JSONEncoder().encode(testData[1])
//let jsonString = String(data: jsonData, encoding: .utf8)!
//
// JSON -> activity
//let jsonDataBack = jsonString.data(using: .utf8)!
//let activity = try! JSONDecoder().decode(Activity.self, from: jsonDataBack)


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


//struct Comment: Codable {
//    let userID: String
//    let content: String
//    let id: String = UUID().uuidString
//}

struct User: Codable, Equatable {
    var id: String = UUID().uuidString
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

enum Category: String, Codable, CaseIterable {
    case sport = "Sport"
    case game = "Game"
}


enum Subcategory: String, Codable, CaseIterable {
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
    
    static func getRelations() -> [(Category,[Subcategory])] {
        // we have to use list of tuples instead of dicionary because they are ordered, and the pickerView
        // which uses this structure only returns the index of the selected value...
        var dict: [Category:[Subcategory]] = [:]
        var tuples: [(Category,[Subcategory])] = []
        for subcategory in self.allCases {
            dict[subcategory.category] = []
        }
        for subcategory in self.allCases {
            dict[subcategory.category]!.append(subcategory)
        }
        for (key, value) in dict {
            tuples.append((key, value))
        }
        return tuples
    }
}


// testData

//let testData: [Activity] = [
//    Activity(name: "dungeons and dragons",
//             desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description",
//             subcategory: .boardgame,
//             coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935),
//             activityTime: Date(),
//             creatorID: DataBase.data.user!.id
//    ),
//
//    Activity(name: "Fussbal match",
//             desc: "fussbal match zu cruchten",
//             subcategory: .soccer,
//             coordinate: CLLocationCoordinate2D(latitude: 49.621622, longitude: 6.161935),
//             activityTime: Date()
//    )
//]



