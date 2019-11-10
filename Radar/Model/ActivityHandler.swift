//
//  ActivityModel.swift
//  Radar
//
//  Created by Charel FELTEN on 21/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import CoreLocation

// enum tips: https://developerinsider.co/advanced-enum-enumerations-by-example-swift-programming-language/


enum PartOfDay: String {
    case morning = "Morning"
    case noon = "Noon"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}

enum PartOfWeek: String {
    case today = "Today"
    case tomorrow = "Tomorrow"
}


class Time {
    
    static func timeTupleToDate(partOfWeek: PartOfWeek, partOfDay: PartOfDay) -> Date {
        var finalDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())! // finalDate is today, 00:00:00
        
        let hourToAdd: Int
        let dayToAdd: Int
        
        switch partOfWeek {
        case .today: dayToAdd = 0
        case .tomorrow: dayToAdd = 1
        }
        
        switch partOfDay {
        case .morning: hourToAdd = 0
        case .noon: hourToAdd = 11
        case .afternoon: hourToAdd = 14
        case .evening: hourToAdd = 18
        case .night: hourToAdd = 22
        }
        
        finalDate = Calendar.current.date(byAdding: .day, value: dayToAdd, to: finalDate)!
        finalDate = Calendar.current.date(byAdding: .hour, value: hourToAdd, to: finalDate)!
        
        return finalDate
    }
    
    
    static func dateToTimeTuple(date: Date) -> (PartOfWeek, PartOfDay) {
        let currentHour: Int = Calendar.current.component(.hour, from: date)
        
        let partOfDay: PartOfDay
        
        switch currentHour {
            case  0 ... 10: partOfDay = .morning
            case 11 ... 13: partOfDay = .noon
            case 14 ... 17: partOfDay = .afternoon
            case 18 ... 21: partOfDay = .evening
            case 22 ... 24: partOfDay = .night
            default: partOfDay = .morning
        }
        
        let partOfWeek: PartOfWeek = Calendar.current.isDateInToday(date) ? .today : .tomorrow
        
        return (partOfWeek, partOfDay)
    }
    
    
    static func stringFromTimeTuple(partOfWeek: PartOfWeek, partOfDay: PartOfDay) -> String {
        switch (partOfWeek, partOfDay) {
            case (.today, .noon): return "Around noon"
            case (.today, .night): return "Tonight"
            case (.today, _): return "This \(partOfDay.rawValue)"
            default: return "\(partOfWeek.rawValue) \(partOfDay.rawValue)"
        }
    }
       
    
    static func getPossibleTimesOfDay() -> [PartOfDay] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        var possibleTimes: [PartOfDay] = []
        
        switch currentHour {
            case  0 ... 10:
                possibleTimes.append(contentsOf: [.morning, .noon, .afternoon, .evening, .night])
            case 11 ... 13:
                possibleTimes.append(contentsOf: [.noon, .afternoon, .evening, .night])
            case 14 ... 17:
                possibleTimes.append(contentsOf: [.afternoon, .evening, .night])
            case 18 ... 21:
                possibleTimes.append(contentsOf: [.evening, .night])
            case 22 ... 24:
                possibleTimes.append(.night)
            default:
                break
        }
        
        return possibleTimes
    }
}








//
//
//class ActivityHandler {
//
//    static let morning: ClosedRange = 0...10
//    static let noon: ClosedRange = 11...13
//    static let afternoon: ClosedRange = 14...17
//    static let evening: ClosedRange = 18...21
//    static let night: ClosedRange = 22...24
//
//
//    var activityList: [Activity]
//
//
//    // singleton pattern
//    private init(){
//        activityList = []
//    }
//    static let instance = ActivityHandler()
//
////    static func userChoiceToDate(date: String, time: String) -> Date {
////        let currentTime = Date()
////        var activityTime = currentTime
////
////        let hour = Calendar.current.component(.hour, from: currentTime)
////
////        if date == "tomorrow" {
////            activityTime += 24 * 60 * 60
////        }
////
////        switch time {
////        case "morning":
////
////        default:
////            <#code#>
////        }
////    }
//
//
//
////    static dateIntervalToDescription(Da)
//
//    static func getDescriptiveTime(from activityTime: Date) -> String {
//
//        // get day
//        let datum = Calendar.current.component(.day, from: activityTime)
//        let today = Calendar.current.component(.day, from: Date())
//        let descriptiveDay: String
//
//        if datum == today {
//            descriptiveDay = "This"
//        } else {
//            descriptiveDay = "Tomorrow"
//        }
//
//        // get hour
//        let hour = Calendar.current.component(.hour, from: activityTime)
//        let descriptiveHour: String
//
//        switch hour {
//            case morning:
//                descriptiveHour = "Morning"
//            case noon:
//                descriptiveHour = "Noon"
//            case afternoon:
//                descriptiveHour = "Afternoon"
//            case evening:
//                descriptiveHour = "Evening"
//            case night:
//                descriptiveHour = "Night"
//            default:
//                descriptiveHour = "Error"
//        }
//
//        return descriptiveDay + " " + descriptiveHour
//    }
//
//}
//
//    func createActivity (name: String,
//                                description: String,
//                                domain: String,
//                                type: String,
//                                time: String,
//                                date: String,
//                                coordinates: CLLocationCoordinate2D) {
//
//        let activityTime = Date() // temporary implementation
//
//        activityList.append(Activity(name: name,
//                                     desc: description,
//                                     domain: domain,
//                                     type: type,
//                                     coordinate: coordinates,
//                                     activityTime: activityTime))
//
//    }
    
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
//
//
//enum partOfDay: String {
//
//    case morning = "Morning"
//    case noon = "Noon"
//    case afternoon = "afternoon"
//    case evening = "evening"
//    case night = "night"
//
////    var range: ClosedRange<Int> {
////        switch self {
////        case .morning: return 0 ... 10
////        case .noon: return 11 ... 13
////        case .afternoon: return 14 ... 17
////        case .evening: return 18 ... 21
////        case .night: return 22 ... 24
////        }
////    }
//
//    init(date: Date) {
//        switch Calendar.current.component(.hour, from: date) {
//        case  0 ... 10: self = .morning
//        case 11 ... 13: self = .noon
//        case 14 ... 17: self = .afternoon
//        case 18 ... 21: self = .evening
//        case 22 ... 24: self = .night
//        default: self = .morning
//        }
//    }
//}
