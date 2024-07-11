//
//  HomeViewModel.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 03/07/24.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    private var persistenceService: UserRepository?
    private var modelContext: ModelContext?
    @Published private(set) var user: UserModel = UserModel()
        
    init() { }
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
        self.persistenceService = UserSwiftDataService(modelContext: context)
        if let persistence = persistenceService {
            self.user = persistence.fetchUser()
        }
    }
    
    func setUserName(name: String) {
        persistenceService?.setUserName(name: name)
        self.user = persistenceService?.fetchUser() ?? UserModel()
    }
    
    func addObjective(objective: ObjectiveModel) {
        persistenceService?.addObjective(objective: objective)
    }

    func updateObjective(objective: ObjectiveModel) {
        persistenceService?.updateObjective(objective: objective)
    }

    func fetchObjectives() -> [ObjectiveModel]? {
        return persistenceService?.fetchObjectives()
    }

    func deleteObjective(objective: ObjectiveModel) {
        persistenceService?.deleteObjective(objective: objective)
    }
    
    func addHabit(to objective: ObjectiveModel, habit: HabitModel) {
        persistenceService?.addHabit(to: objective, habit: habit)
    }

    func updateHabit(habit: HabitModel) {
        persistenceService?.updateHabit(habit: habit)
    }
    
    func fetchAllHabtis() -> [HabitModel]? {
        return persistenceService?.fetchAllHabtis()
    }
    
    func deleteHabit(id: UUID) {
        persistenceService?.deleteHabit(id: id)
    }
}
