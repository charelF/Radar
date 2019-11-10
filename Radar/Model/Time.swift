//
//  Time.swift
//  Radar
//
//  Created by Charel FELTEN on 21/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation
import CoreLocation

// enum tips: https://developerinsider.co/advanced-enum-enumerations-by-example-swift-programming-language/


enum PartOfDay: String, CaseIterable {
    case morning = "Morning"
    case noon = "Noon"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}

enum PartOfWeek: String, CaseIterable {
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
    
    
    static func stringFromDate(from date: Date) -> String {
        let tuple = dateToTimeTuple(date: date)
        return stringFromTimeTuple(partOfWeek: tuple.0, partOfDay: tuple.1)
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
