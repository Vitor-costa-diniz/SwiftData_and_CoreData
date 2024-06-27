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
    var name: String?
    var notes: String?
    var startDate: Date?
    @Relationship(deleteRule: .cascade) var habits: [Habit]?
    
    init(name: String? = nil,
         notes: String? = nil,
         startDate: Date? = nil,
         habits: [Habit]? = nil) {
        self.name = name
        self.notes = notes
        self.startDate = startDate
        self.habits = habits
    }
}
