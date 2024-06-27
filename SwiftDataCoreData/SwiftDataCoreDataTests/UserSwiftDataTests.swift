//
//  UserSwiftDataTests.swift
//  SwiftDataCoreDataTests
//
//  Created by Vitor Costa on 27/06/24.
//

import XCTest
import SwiftData
@testable import SwiftDataCoreData

final class UserSwiftDataServiceTests: XCTestCase {
    var viewModel: MockViewModelSwiftData!
    var modelContext: ModelContext!

    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        viewModel = MockViewModelSwiftData(modelContext: container.mainContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        modelContext = nil
    }

    func test_add_user() throws {
        viewModel.setUserName(name: "vitor")
        XCTAssertEqual(viewModel.user.name, "vitor", "User name should be Vitor")
    }

    func test_add_objetive() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Testar", "Objetive name should be Testar")
    }

    func test_update_objetive() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Testar", "Objetive name should be Testar")

        mockObjetive.name = "Teste2"
        viewModel.updateObjective(objective: mockObjetive)

        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Teste2", "Objetive name should be Teste2")
    }

    func test_list_objetives() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)

        let listObjectives = viewModel.fetchObjectives()
        XCTAssertNotNil(listObjectives, "Objective list should not be nil")
    }

    func test_delete_objetive() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Testar", "Objetive name should be Testar")

        viewModel.deleteObjective(objective: mockObjetive)
        XCTAssertNil(viewModel.user.objectives?.first, "Objective should be nil")
    }

    func test_add_habit() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        let mockHabit = Habit(name: "Noite", notes: "Teste ne paizao")
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)

        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        let firstHabit = viewModel.user.objectives?.first?.habits?.first
        XCTAssertEqual(firstHabit?.name, "Noite", "Habit name should be Noite")
    }

    func test_update_habit() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        let mockHabit = Habit(name: "Noite", notes: "Teste ne paizao")
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)

        mockHabit.name = "Manha"
        viewModel.updateHabit(habit: mockHabit)

        let firstHabit = viewModel.user.objectives?.first?.habits?.first
        XCTAssertEqual(firstHabit?.name, "Manha", "Habit name should be Noite")
    }

    func test_list_habits() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        let mockHabit = Habit(name: "Noite", notes: "Teste ne paizao")
        let mockHabit2 = Habit(name: "Manha", notes: "Dormir que sou fraco")

        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit2)

        let listHabits = viewModel.fetchHabits(for: mockObjetive)

        XCTAssertEqual(listHabits?.count, 2, "Habit count should be equal to 2")
    }

    func test_delete_habit() throws {
        let mockObjetive = Objective(name: "Testar", startDate: Date())
        let mockHabit = Habit(name: "Noite", notes: "Teste ne paizao")
        let mockHabit2 = Habit(name: "Manha", notes: "Dormir que sou fraco")

        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit2)
        viewModel.deleteHabit(id: mockHabit.id)

        let listHabits = viewModel.fetchHabits(for: mockObjetive)

        XCTAssertEqual(listHabits?.count, 1, "Habit count should be equal to 1")
        XCTAssertEqual(listHabits?.first?.name, "Manha", "Habit first position name should be Manha")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

class MockViewModelSwiftData {
    private let userSwiftDataService: UserRepository
    private let modelContext: ModelContext
    @Published private(set) var user: User

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.userSwiftDataService = UserSwiftDataService(modelContext: modelContext)
        self.user = userSwiftDataService.fetchUser()
    }

    func fetchData() {
        self.user = userSwiftDataService.fetchUser()
    }

    func setUserName(name: String) {
        userSwiftDataService.setUserName(name: name)
        fetchData()
    }

    func addObjective(objective: Objective) {
        userSwiftDataService.addObjective(objective: objective)
    }

    func updateObjective(objective: Objective) {
        userSwiftDataService.updateObjective(objective: objective)
    }

    func fetchObjectives() -> [Objective]? {
        return userSwiftDataService.fetchObjectives()
    }

    func deleteObjective(objective: Objective) {
        userSwiftDataService.deleteObjective(objective: objective)
    }

    func addHabit(to objective: Objective, habit: Habit) {
        userSwiftDataService.addHabit(to: objective, habit: habit)
    }

    func updateHabit(habit: Habit) {
        userSwiftDataService.updateHabit(habit: habit)
    }

    func fetchHabits(for objective: Objective) -> [Habit]? {
        return userSwiftDataService.fetchHabits(for: objective)
    }

    func deleteHabit(id: UUID) {
        userSwiftDataService.deleteHabit(id: id)
    }
}
