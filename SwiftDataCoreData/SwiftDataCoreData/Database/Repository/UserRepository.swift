//
//  UserRepository.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation

protocol UserRepository {
    func fetchUser() -> UserModel
    func setUserName(name: String)
    func addObjective(objective: ObjectiveModel)
    func updateObjective(objective: ObjectiveModel)
    func fetchObjectives() -> [ObjectiveModel]?
    func deleteObjective(objective: ObjectiveModel)
    func addHabit(to objective: ObjectiveModel, habit: HabitModel)
    func updateHabit(habit: HabitModel)
    func fetchHabits(for objective: ObjectiveModel) -> [HabitModel]?
    func fetchAllHabtis() -> [HabitModel]?
    func deleteHabit(id: UUID)
}
