//
//  Activity.swift
//  Radar
//
//  Created by Charel FELTEN on 30/09/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import MapKit

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
    
    let creationTime: Date
    let activityTime: Date
    
    //let id: String = UUID().uuidString
    /// while the above way of initialising an activity might look nice, it causes problems when the activity is decoded from JSON,
    /// as these values are newly computed so the decoded activity gets a new uuid instead of being reassigned the decoded one
    let id: String
    
    var participantIDs: [String] = []
    let creatorID: String
    
    /// Despite activity being a struct, an initialiser was necessary because of the way the category and emoji values are set
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
        self.creationTime = Date()
        self.id = UUID().uuidString
        
        self.creatorID = creatorID
        self.participantIDs.append(creatorID)
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    var keyWords: [String] {
        return [self.name,
                self.emoji,
                self.category.rawValue,
                self.subcategory.rawValue]
    }
}

/// activity can now be manually encoded and decoded like this:

// activity -> JSON
//let jsonData = try! JSONEncoder().encode(testData[1])
//let jsonString = String(data: jsonData, encoding: .utf8)!

// JSON -> activity
//let jsonDataBack = jsonString.data(using: .utf8)!
//let activity = try! JSONDecoder().decode(Activity.self, from: jsonDataBack)


class ActivityWrapper: NSObject, MKAnnotation {
    // this class encapsulates/contains a struct representing an activity.
    // it is necessary for MapKit, which requires objects that implement MKAnnotation for its annotations
    
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
        return activities.map { ActivityWrapper($0) }
    }
    
    static func wrap(for activities: [String:Activity]) -> [ActivityWrapper] {
        return activities.map { ActivityWrapper($1) }
    }
}

// custom coordinate struct that represents a coordinate that implements codable
// below is an extension to CLLocationCoordinate2D to allow transformation between the two
// coordinate representations. Both are needed, as the second is required by MapKit
// https://www.objc.io/blog/2018/10/23/custom-types-for-codable/
struct Coordinate: Codable, Hashable {
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

struct User: Codable, Equatable {
    var id: String = UUID().uuidString
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

enum Category: String, Codable, CaseIterable {
    case sport = "Sport"
    case game = "Game"
    case social = "Social"
}

// This enum represents a subcategory, but each instance contains 2 computed properties that
// represent the corresponding category and emoji.
enum Subcategory: String, Codable, CaseIterable {
    case soccer = "Soccer"
    case basketball = "Basketball"
    case tennis = "Tennis"
    case climbing = "Climbing"
    
    case videogame = "Videogame"
    case boardgame = "Boardgame"
    case actiongame = "Actiongame"
    
    case bar = "Bar"
    
    var category: Category {
        switch self {
        case .soccer,
             .basketball,
             .tennis,
             .climbing:
            return .sport
        case .videogame,
             .boardgame,
             .actiongame:
            return .game
        case .bar:
            return .social
        }
    }
    
    var emoji: String {
        switch self {
        case .soccer: return "⚽️"
        case .basketball: return "🏀"
        case .tennis: return "🥎"
        case .climbing: return "🧗"
        
        case .videogame: return "🎮"
        case .boardgame: return "🎲"
        case .actiongame: return "🔫"
        
        case .bar: return "🍺"
        }
    }
    
    // returns a list that shows the relations between categories and subcategories.
    // it is a list of tuples instead of a dictionnary because dictionnaries are unordered, and this list
    // is used in a picker view, which returns indexes of selected elements. It is thus important that the indices
    // of each category and subcategory remain the same.
    static func getRelations() -> [(Category,[Subcategory])] {
        
        var dict: [Category:[Subcategory]] = [:]
        
        for subcategory in self.allCases {
            dict[subcategory.category] = []
        }
        
        for subcategory in self.allCases {
            dict[subcategory.category]!.append(subcategory)
        }
        
        var tuples: [(Category,[Subcategory])] = []
        
        for (key, value) in dict {
            tuples.append((key, value))
        }
        
        return tuples.sorted(by: {$0.0.rawValue > $1.0.rawValue})
    }
}

enum ActivityContext: String, CaseIterable {
    case all = "All"
    case me = "Mine"
    case participating = "Participating"
}
