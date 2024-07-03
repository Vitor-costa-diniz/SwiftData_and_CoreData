//
//  HomeViewModel.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 03/07/24.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    private let persistenceService: UserRepository
    private let modelContext: ModelContext
    @Published private(set) var user: User
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        persistenceService = UserSwiftDataService(modelContext: modelContext)
        self.user = persistenceService.fetchUser()
    }
}
