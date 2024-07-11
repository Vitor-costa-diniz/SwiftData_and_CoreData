//
//  UserSwiftDataService.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation
import SwiftData

class UserSwiftDataService: UserRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchUser() -> UserModel {
        var user = UserModel()
        do {
            let descriptor = FetchDescriptor<UserSwiftData>(sortBy: [SortDescriptor(\.name)])
            if let fetchedUser = try modelContext.fetch(descriptor).first {
                user = UserModel(userSwiftData: fetchedUser)
            }
        } catch {
            print("Fetch user failed: \(error)")
        }
        return user
    }
    
    func setUserName(name: String) {
        do {
            let user = fetchUSerSwiftData()
            user.name = name
            modelContext.insert(user)
            try modelContext.save()
        } catch {
            print("Failed to set user name: \(error)")
        }
    }
    
    func addObjective(objective: ObjectiveModel) {
        do {
            let user = fetchUSerSwiftData()
            user.objectives?.append(objective.toObjectiveSwiftData())
            modelContext.insert(objective.toObjectiveSwiftData())
            try modelContext.save()
        } catch {
            print("Failed to add objective: \(error)")
        }
    }

    func updateObjective(objective: ObjectiveModel) {
        let objectiveSwiftData = objective.toObjectiveSwiftData()
        do {
            if var objectiveToUpdate = modelContext.model(for: objectiveSwiftData.id) as? ObjectiveSwiftData {
                objectiveToUpdate = objectiveSwiftData
                modelContext.insert(objectiveToUpdate)
                try modelContext.save()
            }
        } catch {
            print("Failed to update objective: \(error)")
        }
    }
    
    func fetchObjectives() -> [ObjectiveModel]? {
        let user = fetchUser()
        return user.objectives
    }
    
    func deleteObjective(objective: ObjectiveModel) {
        do {
            let user = fetchUSerSwiftData()
            user.objectives = user.objectives?.filter { $0.id != objective.id }
            modelContext.delete(objective.toObjectiveSwiftData())
            try modelContext.save()
        } catch {
            print("Failed to delete objective: \(error)")
        }
    }
    
    func addHabit(to objective: ObjectiveModel, habit: HabitModel) {
        do {
            let user = fetchUSerSwiftData()
            if let index = user.objectives?.firstIndex(where: { $0.id == objective.id }) {
                user.objectives?[index].habits?.append(habit.toHabitSwiftData())
                modelContext.insert(habit.toHabitSwiftData())
                try modelContext.save()
            }
        } catch {
            print("Failed to add habit: \(error)")
        }
    }
    
    func updateHabit(habit: HabitModel) {
        let habitSwiftData = habit.toHabitSwiftData()
        do {
            if var habitToUpdate = modelContext.model(for: habitSwiftData.id) as? HabitSwiftData {
                habitToUpdate = habitSwiftData
                modelContext.insert(habitToUpdate)
                try modelContext.save()
            }
        } catch {
            print("Failed to update habit: \(error)")
        }
    }
    
    func fetchHabits(for objective: ObjectiveModel) -> [HabitModel]? {
        return objective.habits
    }
    
    func fetchAllHabtis() -> [HabitModel]? {
        var habit: [HabitModel] = []
        let user = fetchUSerSwiftData()
        user.objectives?.forEach({ objective in
            objective.habits?.forEach({
                habit.append(HabitModel(habitSwiftData: $0))
            })
        })
        return habit
        /// In this way, i imagine if i dont called this func on the onAppear it will not be called every time that was a change in the habits list.
//        var habits: [Habit] = []
//        let descriptor = FetchDescriptor<Habit>()
//        do {
//            habits = try modelContext.fetch(descriptor)
//        } catch {
//            print("Fetch habits failed: \(error)")
//        }
//        return habits
    }
    
    func deleteHabit(id: UUID) {
        do {
            var user = fetchUser()
            for (index, objective) in (user.objectives ?? []).enumerated() {
                user.objectives?[index].habits = objective.habits?.filter { $0.id != id }
            }
            let descriptor = FetchDescriptor<HabitSwiftData>(predicate: #Predicate { $0.id == id })
            if let habitToDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(habitToDelete)
                try modelContext.save()
            }
        } catch {
            print("Failed to delete habit: \(error)")
        }
    }
}

extension UserSwiftDataService {
    private func fetchUSerSwiftData() -> UserSwiftData {
        var user = UserSwiftData()
        do {
            let descriptor = FetchDescriptor<UserSwiftData>(sortBy: [SortDescriptor(\.name)])
            if let fetchedUser = try modelContext.fetch(descriptor).first {
                user = fetchedUser
            }
        } catch {
            print("Fetch user failed: \(error)")
        }
        return user
    }
}

