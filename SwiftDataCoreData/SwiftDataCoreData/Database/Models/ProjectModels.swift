//
//  ProjectModels.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation
import CoreData

class UserModel {
    var name: String?
    var objectives: [ObjectiveModel]?
    
    init(name: String? = nil, objectives: [ObjectiveModel]? = nil) {
        self.name = name
        self.objectives = objectives
    }
    
    init(userSwiftData: UserSwiftData) {
        self.name = userSwiftData.name
        if let objectivesArray = userSwiftData.objectives {
            self.objectives = objectivesArray.map { ObjectiveModel(objectiveSwiftData: $0) }
        } else {
            self.objectives = nil
        }
    }
}

class ObjectiveModel: Identifiable, Equatable, Hashable {
    var id: UUID
    var name: String
    var startDate: Date
    var notes: String?
    var habits: [HabitModel]?
    
    init(name: String, startDate: Date, notes: String? = nil, habits: [HabitModel]? = nil) {
        self.id = UUID()
        self.name = name
        self.startDate = startDate
        self.notes = notes
        self.habits = habits
    }
    
    init(objectiveSwiftData: ObjectiveSwiftData) {
        self.id = objectiveSwiftData.id
        self.name = objectiveSwiftData.name
        self.startDate = objectiveSwiftData.startDate
        self.notes = objectiveSwiftData.notes
        if let habitsArray = objectiveSwiftData.habits {
            self.habits = habitsArray.map { HabitModel(habitSwiftData: $0) }
        } else {
            self.habits = nil
        }
    }
    
    static func == (lhs: ObjectiveModel, rhs: ObjectiveModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class HabitModel: Identifiable {
    var id: UUID
    var name: String
    var date: Date
    var place: String
    var notes: String?
    
    init(name: String, date: Date, place: String, notes: String? = nil) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.place = place
        self.notes = notes
    }
    
    init(habitSwiftData: HabitSwiftData) {
        self.id = habitSwiftData.id
        self.name = habitSwiftData.name
        self.date = habitSwiftData.date
        self.place = habitSwiftData.place
        self.notes = habitSwiftData.notes
    }
}

extension ObjectiveModel {
    func toObjectiveSwiftData() -> ObjectiveSwiftData {
        let habitsSwiftData = self.habits?.map { $0.toHabitSwiftData() }
        return ObjectiveSwiftData(
            id: self.id,
            name: self.name,
            startDate: self.startDate,
            notes: self.notes,
            habits: habitsSwiftData
        )
    }
}

extension HabitModel {
    func toHabitSwiftData() -> HabitSwiftData {
        return HabitSwiftData(
            id: self.id,
            name: self.name,
            date: self.date,
            place: self.place,
            notes: self.notes
        )
    }
}
