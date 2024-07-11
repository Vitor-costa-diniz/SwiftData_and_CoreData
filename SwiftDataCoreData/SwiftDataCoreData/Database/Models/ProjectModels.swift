//
//  ProjectModels.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation

struct UserModel {
    var name: String?
    var objectives: [ObjectiveModel]?
    
    init(name: String? = nil, objectives: [ObjectiveModel]? = nil) {
        self.name = name
        self.objectives = objectives
    }
    
    init(userCoreData: UserCoreData) {
        self.name = userCoreData.name
        if let objectivesSet = userCoreData.objectives as? Set<ObjectiveCoreData> {
            self.objectives = objectivesSet.map { ObjectiveModel(objectiveCoreData: $0) }
        } else {
            self.objectives = nil
        }
    }
}

struct ObjectiveModel {
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
    
    init(objectiveCoreData: ObjectiveCoreData) {
        self.id = objectiveCoreData.id ?? UUID()
        self.name = objectiveCoreData.name ?? ""
        self.startDate = objectiveCoreData.startDate ?? Date()
        self.notes = objectiveCoreData.notes
        if let habitsSet = objectiveCoreData.habits as? Set<HabitCoreData> {
            self.habits = habitsSet.map { HabitModel(habitCoreData: $0) }
        } else {
            self.habits = nil
        }
    }
}

struct HabitModel {
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
    
    init(habitCoreData: HabitCoreData) {
        self.id = habitCoreData.id ?? UUID()
        self.name = habitCoreData.name ?? ""
        self.date = habitCoreData.date ?? Date()
        self.place = habitCoreData.place ?? ""
        self.notes = habitCoreData.notes
    }
}
