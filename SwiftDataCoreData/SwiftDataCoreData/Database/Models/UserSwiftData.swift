//
//  User.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation

import SwiftData

@Model
class UserSwiftData {
    var name: String?
    @Relationship(deleteRule: .cascade) var objectives: [ObjectiveSwiftData]?
    
    init(name: String? = nil,
         objectives: [ObjectiveSwiftData]? = nil) {
        self.name = name
        self.objectives = objectives
    }
}
