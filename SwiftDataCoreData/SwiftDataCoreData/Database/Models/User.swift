//
//  User.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation

import SwiftData

@Model
class User {
    var name: String?
    @Relationship(deleteRule: .cascade) var objectives: [Objective]?
    
    init(name: String? = nil,
         objectives: [Objective]? = nil) {
        self.name = name
        self.objectives = objectives
    }
}
