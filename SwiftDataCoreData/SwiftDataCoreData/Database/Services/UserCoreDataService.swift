//
//  UserCoreDataService.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation
import CoreData

class UserCoreDataService: UserRepository {
    func fetchUser() -> UserModel {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        
        do {
            if let userCoreData = try context.fetch(fetchRequest).first {
                return UserModel(userCoreData: userCoreData)
            }
        } catch {
            return UserModel()
        }
    }
    
    func setUserName(name: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        var user = fetchUser()
        
        user.name = name
        
        CoreDataStack.shared.saveContext()
    }
    
    func addObjective(objective: ObjectiveModel) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let user = fetchUserCoreData()
        let objectiveCoreData = ObjectiveCoreData(context: context)
        
        objectiveCoreData.id = objective.id
        objectiveCoreData.name = objective.name
        objectiveCoreData.startDate = objective.startDate
        objectiveCoreData.notes = objective.notes
        if let habits = objective.habits {
            for habit in habits {
                let habitCoreData = habit.toHabitCoreData(context: context)
                objectiveCoreData.addToHabits(habitCoreData)
            }
        }
        
        user.addToObjectives(objectiveCoreData)
        CoreDataStack.shared.saveContext()
    }
    
    func updateObjective(objective: ObjectiveModel) {
        let objectiveToUpdate = findObjectiveById(id: objective.id)
        objectiveToUpdate?.name = objective.name
        objectiveToUpdate?.startDate = objective.startDate
        objectiveToUpdate?.notes = objective.notes
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchObjectives() -> [ObjectiveModel]? {
        let user = fetchUser()
        return user.objectives
    }
    
    func deleteObjective(objective: ObjectiveModel) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let user = fetchUserCoreData()
        let objectiveCoreData = objective.toObjectiveCoreData(context: context)
        
        user.removeFromObjectives(objectiveCoreData)
        
        CoreDataStack.shared.saveContext()
    }
    
    func addHabit(to objective: ObjectiveModel, habit: HabitModel) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let objectiveCoreData = findObjectiveById(id: objective.id)
        let habitCoreData = habit.toHabitCoreData(context: context)
        
        objectiveCoreData?.addToHabits(habitCoreData)
        
        CoreDataStack.shared.saveContext()
    }
    
    func updateHabit(habit: HabitModel) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let habitCoreData = findHabitById(id: habit.id)
        
        habitCoreData?.name = habit.name
        habitCoreData?.date = habit.date
        habitCoreData?.place = habit.place
        habitCoreData?.notes = habit.notes
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchHabits(for objective: ObjectiveModel) -> [HabitModel]? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let objectiveCoreData = findObjectiveById(id: objective.id)
        
        let habits = objectiveCoreData?.habits?.compactMap({ habitCoreData in
            HabitModel(habitCoreData: habitCoreData as! HabitCoreData)
        })
        
        return habits
    }
    
    func fetchAllHabtis() -> [HabitModel]? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        var habitsModel: [HabitModel]? = []
        
        do {
            let habits = try context.fetch(fetchRequest)
            habits.forEach({
                habitsModel?.append(HabitModel(habitCoreData: $0))
            })
            return habitsModel
        } catch {
            print("Failed to fetch objective by ID: \(error)")
            return nil
        }
    }
    
    func deleteHabit(id: UUID) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let habitToDelete = try context.fetch(fetchRequest).first {
                context.delete(habitToDelete)
                CoreDataStack.shared.saveContext()
            }
        } catch {
            print("Failed to delete habit: \(error)")
        }
    }
}

extension UserCoreDataService {
    private func fetchUserCoreData() -> UserCoreData {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        var userCoreData: UserCoreData = UserCoreData()
        
        do {
            if let user = try context.fetch(fetchRequest).first {
                userCoreData = user
            }
            return userCoreData
        } catch {
            return UserCoreData()
        }
    }
    
    private func findObjectiveById(id: UUID) -> ObjectiveCoreData? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ObjectiveCoreData> = ObjectiveCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch objective by ID: \(error)")
            return nil
        }
    }  
    
    private func findHabitById(id: UUID) -> HabitCoreData? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch objective by ID: \(error)")
            return nil
        }
    }
}
