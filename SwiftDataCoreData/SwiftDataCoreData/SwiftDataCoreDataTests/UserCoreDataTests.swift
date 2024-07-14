//
//  UserCoreDataTests.swift
//  SwiftDataCoreDataTests
//
//  Created by Vitor Costa on 14/07/24.
//

import XCTest
@testable import SwiftDataCoreData

final class UserCoreDataTests: XCTestCase {
    var viewModel: MockViewModelCoreData!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        viewModel = MockViewModelCoreData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_add_user() throws {
        viewModel.setUserName(name: "vitor")
        XCTAssertEqual(viewModel.user.name, "vitor", "User name should be Vitor")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

class MockViewModelCoreData {
    private let userSwiftDataService: UserRepository
    private let coreDataStack: TestCoreDataStack
    @Published private(set) var user: UserModel
    
    init() {
        self.coreDataStack = TestCoreDataStack()
        self.userSwiftDataService = UserCoreDataService(coreDataStack: coreDataStack)
        self.user = userSwiftDataService.fetchUser()
    }
    
    func fetchData() {
        self.user = userSwiftDataService.fetchUser()
    }

    func setUserName(name: String) {
        userSwiftDataService.setUserName(name: name)
        fetchData()
    }

    func addObjective(objective: ObjectiveModel) {
        userSwiftDataService.addObjective(objective: objective)
        fetchData()
    }

    func updateObjective(objective: ObjectiveModel) {
        userSwiftDataService.updateObjective(objective: objective)
        fetchData()
    }

    func fetchObjectives() -> [ObjectiveModel]? {
        return userSwiftDataService.fetchObjectives()
    }

    func deleteObjective(objective: ObjectiveModel) {
        userSwiftDataService.deleteObjective(objective: objective)
        fetchData()
    }

    func addHabit(to objective: ObjectiveModel, habit: HabitModel) {
        userSwiftDataService.addHabit(to: objective, habit: habit)
        fetchData()
    }

    func updateHabit(habit: HabitModel) {
        userSwiftDataService.updateHabit(habit: habit)
        fetchData()
    }

    func fetchHabits(for objective: ObjectiveModel) -> [HabitModel]? {
        return userSwiftDataService.fetchHabits(for: objective)
    }
    
    func fetchAllHabits() -> [HabitModel]? {
        return userSwiftDataService.fetchAllHabtis()
    }

    func deleteHabit(id: UUID) {
        userSwiftDataService.deleteHabit(id: id)
        fetchData()
    }
}
