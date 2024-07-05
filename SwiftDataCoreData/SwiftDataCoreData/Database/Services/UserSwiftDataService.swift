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
    
    func fetchUser() -> User {
        var user = User()
        do {
            let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
            if let fetchedUser = try modelContext.fetch(descriptor).first {
                user = fetchedUser
            }
        } catch {
            print("Fetch user failed: \(error)")
        }
        return user
    }
    
    func setUserName(name: String) {
        do {
            let user = fetchUser()
            user.name = name
            modelContext.insert(user)
            try modelContext.save()
        } catch {
            print("Failed to set user name: \(error)")
        }
    }
    
    func addObjective(objective: Objective) {
        do {
            let user = fetchUser()
            user.objectives?.append(objective)
            modelContext.insert(objective)
            try modelContext.save()
        } catch {
            print("Failed to add objective: \(error)")
        }
    }

    func updateObjective(objective: Objective) {
        do {
            if var objectiveToUpdate = modelContext.model(for: objective.id) as? Objective {
                objectiveToUpdate = objective
                modelContext.insert(objectiveToUpdate)
                try modelContext.save()
            }
        } catch {
            print("Failed to update objective: \(error)")
        }
    }
    
    func fetchObjectives() -> [Objective]? {
        let user = fetchUser()
        return user.objectives
    }
    
    func deleteObjective(objective: Objective) {
        do {
            let user = fetchUser()
            user.objectives = user.objectives?.filter { $0.id != objective.id }
            modelContext.delete(objective)
            try modelContext.save()
        } catch {
            print("Failed to delete objective: \(error)")
        }
    }
    
    func addHabit(to objective: Objective, habit: Habit) {
        do {
            let user = fetchUser()
            if let index = user.objectives?.firstIndex(where: { $0.id == objective.id }) {
                user.objectives?[index].habits?.append(habit)
                modelContext.insert(habit)
                try modelContext.save()
            }
        } catch {
            print("Failed to add habit: \(error)")
        }
    }
    
    func updateHabit(habit: Habit) {
        do {
            if var habitToUpdate = modelContext.model(for: habit.id) as? Habit {
                habitToUpdate = habit
                modelContext.insert(habitToUpdate)
                try modelContext.save()
            }
        } catch {
            print("Failed to update habit: \(error)")
        }
    }
    
    func fetchHabits(for objective: Objective) -> [Habit]? {
        return objective.habits
    }
    
    func fetchAllHabtis() -> [Habit]? {
        var habit: [Habit] = []
        let user = fetchUser()
        user.objectives?.forEach({ objective in
            objective.habits?.forEach({
                habit.append($0)
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
            let user = fetchUser()
            for (index, objective) in (user.objectives ?? []).enumerated() {
                user.objectives?[index].habits = objective.habits?.filter { $0.id != id }
            }
            let descriptor = FetchDescriptor<Habit>(predicate: #Predicate { $0.id == id })
            if let habitToDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(habitToDelete)
                try modelContext.save()
            }
        } catch {
            print("Failed to delete habit: \(error)")
        }
    }
}

