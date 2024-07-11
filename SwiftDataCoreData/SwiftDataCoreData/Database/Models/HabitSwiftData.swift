//
//  Habit.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation
import SwiftData

@Model
class HabitSwiftData {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var date: Date
    var place: String
    var notes: String?
    
    init(name: String,
         date: Date,
         place: String,
         notes: String? = nil) {
        self.name = name
        self.date = date
        self.place = place
        self.notes = notes
    }
}

