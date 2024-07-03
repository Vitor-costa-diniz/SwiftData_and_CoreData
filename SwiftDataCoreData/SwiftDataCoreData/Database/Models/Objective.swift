//
//  Objective.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation
import SwiftData

@Model
class Objective {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var startDate: Date
    var notes: String?
    @Relationship(deleteRule: .cascade) var habits: [Habit]?
    
    init(name: String,
         startDate: Date,
         notes: String? = nil,
         habits: [Habit]? = nil) {
        self.name = name
        self.notes = notes
        self.startDate = startDate
        self.habits = habits
    }
}
