//
//  ProjectModels.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation
import CoreData

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
    
    init(userSwiftData: UserSwiftData) {
        self.name = userSwiftData.name
        if let objectivesArray = userSwiftData.objectives {
            self.objectives = objectivesArray.map { ObjectiveModel(objectiveSwiftData: $0) }
        } else {
            self.objectives = nil
        }
    }
}

struct ObjectiveModel: Identifiable, Equatable, Hashable {
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

struct HabitModel: Identifiable {
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
    
    init(habitSwiftData: HabitSwiftData) {
        self.id = habitSwiftData.id
        self.name = habitSwiftData.name
        self.date = habitSwiftData.date
        self.place = habitSwiftData.place
        self.notes = habitSwiftData.notes
    }
}

extension ObjectiveModel {
    func toObjectiveCoreData(context: NSManagedObjectContext) -> ObjectiveCoreData {
        let objectiveCoreData = ObjectiveCoreData(context: context)
        objectiveCoreData.id = self.id
        objectiveCoreData.name = self.name
        objectiveCoreData.startDate = self.startDate
        objectiveCoreData.notes = self.notes
        
        if let habits = self.habits {
            for habit in habits {
                let habitCoreData = habit.toHabitCoreData(context: context)
                objectiveCoreData.addToHabits(habitCoreData)
            }
        }
        return objectiveCoreData
    }
}

extension HabitModel {
    func toHabitCoreData(context: NSManagedObjectContext) -> HabitCoreData {
        let habitCoreData = HabitCoreData(context: context)
        habitCoreData.id = self.id
        habitCoreData.name = self.name
        habitCoreData.date = self.date
        habitCoreData.place = self.place
        habitCoreData.notes = self.notes
        return habitCoreData
    }
}
