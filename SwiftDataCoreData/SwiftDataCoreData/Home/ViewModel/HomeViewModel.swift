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
    @Published private(set) var user: User = User()
        
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
        self.user = persistenceService?.fetchUser() ?? User()
    }
    
    func addObjective(objective: Objective) {
        persistenceService?.addObjective(objective: objective)
    }

    func updateObjective(objective: Objective) {
        persistenceService?.updateObjective(objective: objective)
    }

    func fetchObjectives() -> [Objective]? {
        return persistenceService?.fetchObjectives()
    }

    func deleteObjective(objective: Objective) {
        persistenceService?.deleteObjective(objective: objective)
    }
}
