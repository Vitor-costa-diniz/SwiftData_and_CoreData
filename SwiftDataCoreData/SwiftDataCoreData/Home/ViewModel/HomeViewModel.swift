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
         self.user = persistenceService?.fetchUser() ?? User()
     }
}
