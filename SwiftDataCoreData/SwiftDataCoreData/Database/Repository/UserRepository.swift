//
//  UserRepository.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation

protocol UserRepository {
    func fetchUser() -> User
    func setUserName(name: String)
    func addObjective(objective: Objective)
    func updateObjective(objective: Objective)
    func fetchObjectives() -> [Objective]?
    func deleteObjective(objective: Objective)
    func addHabit(to objective: Objective, habit: Habits)
    func updateHabit(habit: Habits)
    func fetchHabits(for objective: Objective) -> [Habits]?
    func deleteHabit(id: UUID)
}
