//
//  User.swift
//  Radar
//
//  Created by Charel FELTEN on 21/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import Foundation

class User {
    
    let username: String
    let id: UUID
    let activities: [Activity] = []
    let languages: [String] = []
    
    init(username: String) {
        self.username = username
        self.id = UUID()
    }
    
}


