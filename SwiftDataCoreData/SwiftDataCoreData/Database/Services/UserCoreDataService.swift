//
//  UserCoreDataService.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation
import CoreData

class UserCoreDataService: UserRepository {
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    func fetchUser() -> UserModel {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        var userModel: UserModel = UserModel()
        
        do {
            if let userCoreData = try context.fetch(fetchRequest).first {
                userModel = UserModel(userCoreData: userCoreData)
            }
        } catch {
            return UserModel()
        }
        return userModel
    }
    
    func setUserName(name: String) {
        let user = fetchUserCoreData()
        user.name = name
        
        coreDataStack.saveContext()
    }
    
    func addObjective(objective: ObjectiveModel) {
        let context = coreDataStack.persistentContainer.viewContext
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
        coreDataStack.saveContext()
    }
    
    func updateObjective(objective: ObjectiveModel) {
        let objectiveToUpdate = findObjectiveById(id: objective.id)
        objectiveToUpdate?.name = objective.name
        objectiveToUpdate?.startDate = objective.startDate
        objectiveToUpdate?.notes = objective.notes
        
        coreDataStack.saveContext()
    }
    
    func fetchObjectives() -> [ObjectiveModel]? {
        let user = fetchUser()
        return user.objectives
    }
    
    func deleteObjective(objective: ObjectiveModel) {
        let context = coreDataStack.persistentContainer.viewContext
        
        if let ObjectiveCoreData = findObjectiveById(id: objective.id) {
            context.delete(ObjectiveCoreData)
            
            coreDataStack.saveContext()
        } else {
            print("Habit with ID \(objective.id) not found.")
        }
    }
    
    func addHabit(to objective: ObjectiveModel, habit: HabitModel) {
        let context = coreDataStack.persistentContainer.viewContext
        let objectiveCoreData = findObjectiveById(id: objective.id)
        let habitCoreData = habit.toHabitCoreData(context: context)
        
        objectiveCoreData?.addToHabits(habitCoreData)
        
        coreDataStack.saveContext()
    }
    
    func updateHabit(habit: HabitModel) {
        let habitCoreData = findHabitById(id: habit.id)
        
        habitCoreData?.name = habit.name
        habitCoreData?.date = habit.date
        habitCoreData?.place = habit.place
        habitCoreData?.notes = habit.notes
        
        coreDataStack.saveContext()
    }
    
    func fetchHabits(for objective: ObjectiveModel) -> [HabitModel]? {
        let objectiveCoreData = findObjectiveById(id: objective.id)
        
        let habits = objectiveCoreData?.habits?.compactMap({ habitCoreData in
            HabitModel(habitCoreData: habitCoreData as! HabitCoreData)
        })
        
        return habits
    }
    
    func fetchAllHabtis() -> [HabitModel]? {
        let context = coreDataStack.persistentContainer.viewContext
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
        let context = coreDataStack.persistentContainer.viewContext
        
        if let habitCoreData = findHabitById(id: id) {
            context.delete(habitCoreData)
            
            coreDataStack.saveContext()
        } else {
            print("Habit with ID \(id) not found.")
        }
    }
}

extension UserCoreDataService {
    private func fetchUserCoreData() -> UserCoreData {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        
        do {
            if let user = try context.fetch(fetchRequest).first {
                return user
            } else {
                return UserCoreData(context: context)
            }
        } catch {
            print("Error fetching user: \(error)")
            return UserCoreData()
        }
    }
    
    private func findObjectiveById(id: UUID) -> ObjectiveCoreData? {
        let context = coreDataStack.persistentContainer.viewContext
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
        let context = coreDataStack.persistentContainer.viewContext
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
