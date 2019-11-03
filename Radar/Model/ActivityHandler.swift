//
//  ActivityModel.swift
//  Radar
//
//  Created by Charel FELTEN on 21/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import CoreLocation


enum partOfDay: String {
    case morning = "Morning"
    case noon = "Noon"
    case afternoon = "afternoon"
    case evening = "evening"
    case night = "night"
}








class ActivityHandler {
    
    static let morning: ClosedRange = 0...10
    static let noon: ClosedRange = 11...13
    static let afternoon: ClosedRange = 14...17
    static let evening: ClosedRange = 18...21
    static let night: ClosedRange = 22...24
    
    
    var activityList: [Activity]
    
    
    // singleton pattern
    private init(){
        activityList = []
    }
    static let instance = ActivityHandler()
    
//    static func userChoiceToDate(date: String, time: String) -> Date {
//        let currentTime = Date()
//        var activityTime = currentTime
//
//        let hour = Calendar.current.component(.hour, from: currentTime)
//
//        if date == "tomorrow" {
//            activityTime += 24 * 60 * 60
//        }
//
//        switch time {
//        case "morning":
//
//        default:
//            <#code#>
//        }
//    }
    
    static func getPossibleTimesOfDay() -> [String] {
        let currentTime = Date()
        
        let hour = Calendar.current.component(.hour, from: currentTime)
        
        var possibleTimes: [String] = []
        
        switch hour {
            case morning:
                possibleTimes.append(contentsOf: ["morning", "noon", "afternoon", "evening", "night"])
            case noon:
                possibleTimes.append(contentsOf: ["noon", "afternoon", "evening", "night"])
            case afternoon:
                possibleTimes.append(contentsOf: ["afternoon", "evening", "night"])
            case evening:
                possibleTimes.append(contentsOf: ["evening", "night"])
            case night:
                possibleTimes.append("night")
            default:
                possibleTimes.append("error")
        }
        
        return possibleTimes
    }
    
//    static dateIntervalToDescription(Da)
    
    static func getDescriptiveTime(from activityTime: Date) -> String {
        
        // get day
        let datum = Calendar.current.component(.day, from: activityTime)
        let today = Calendar.current.component(.day, from: Date())
        let descriptiveDay: String
        
        if datum == today {
            descriptiveDay = "This"
        } else {
            descriptiveDay = "Tomorrow"
        }
        
        // get hour
        let hour = Calendar.current.component(.hour, from: activityTime)
        let descriptiveHour: String
        
        switch hour {
            case morning:
                descriptiveHour = "Morning"
            case noon:
                descriptiveHour = "Noon"
            case afternoon:
                descriptiveHour = "Afternoon"
            case evening:
                descriptiveHour = "Evening"
            case night:
                descriptiveHour = "Night"
            default:
                descriptiveHour = "Error"
        }
        
        return descriptiveDay + " " + descriptiveHour
    }
    
    
    
    func createActivity (name: String,
                                description: String,
                                domain: String,
                                type: String,
                                time: String,
                                date: String,
                                coordinates: CLLocationCoordinate2D) {
        
        let activityTime = Date() // temporary implementation
        
        activityList.append(Activity(name: name,
                                     desc: description,
                                     domain: domain,
                                     type: type,
                                     coordinate: coordinates,
                                     activityTime: activityTime))
            
    }
    
//    static func testActivities() -> [Activity] {
//        return [
//            Activity(name: "Soccer practice", desc: "hi, we want to play some casual football matches and are looking for some volunteers to join us! ", type: "soccer", coordinate: CLLocationCoordinate2D(latitude: 49.691622, longitude: 6.211935)),
//            Activity(name: "dungeons and dragons", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "boardgame", coordinate: CLLocationCoordinate2D(latitude: 49.631622, longitude: 6.171935)),
//            Activity(name: "lan party", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "videogame", coordinate: CLLocationCoordinate2D(latitude: 49.831622, longitude: 6.071935)),
//            Activity(name: "mtb treffen", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "mountainbike", coordinate: CLLocationCoordinate2D(latitude: 49.431622, longitude: 6.191935)),
//            Activity(name: "drinks @ fabrik", desc: "lets meet for some dnd games! We're a group of 3 people needing one more motivated person to join so we can play. If you are interested, join the activity and we can discuss details in the description", type: "drinks", coordinate: CLLocationCoordinate2D(latitude: 49.531622, longitude: 6.371935))
//        ]
//    }
    
}
