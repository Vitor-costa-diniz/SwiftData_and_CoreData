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
        try super.setUpWithError()
        viewModel = MockViewModelCoreData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
    }

    func test_add_user() throws {
        viewModel.setUserName(name: "vitor")
        XCTAssertEqual(viewModel.user.name, "vitor", "User name should be Vitor")
    }
    
    func test_add_objetive() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Testar", "Objetive name should be Testar")
    }

    func test_update_objetive() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Testar", "Objetive name should be Testar")

        mockObjetive.name = "Teste2"
        viewModel.updateObjective(objective: mockObjetive)

        XCTAssertEqual(viewModel.user.objectives?.first?.name, "Teste2", "Objetive name should be Teste2")
    }

    func test_list_objetives() throws {
        let mockObjetive = ObjectiveModel(name: "Teste add List", startDate: Date())
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)

        let listObjectives = viewModel.fetchObjectives()
        XCTAssertNotNil(listObjectives, "Objective list should not be nil")
    }
    
    // This test sometimes gives errors, I couldn't make it consistent
    func test_delete_objective() throws {
        let mockObjective = ObjectiveModel(name: "Test delete obj", startDate: Date())
        let expectation = XCTestExpectation(description: "Objective added and deleted")
        
        DispatchQueue.global().async {
            self.viewModel.setUserName(name: "vitor")
            self.viewModel.addObjective(objective: mockObjective)
            
            DispatchQueue.main.async {
                XCTAssertEqual(self.viewModel.user.objectives?.first?.name, "Test delete obj", "Objective name should be Test delete obj")
                
                self.viewModel.deleteObjective(objective: mockObjective)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    XCTAssertNil(self.viewModel.user.objectives?.first, "Objective should be nil after deletion")
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }

    
    func test_add_habit() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        let mockHabit = HabitModel(name: "Noite", date: Date(), place: "", notes: "Test Notes")
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)

        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        let firstHabit = viewModel.user.objectives?.first?.habits?.first
        XCTAssertEqual(firstHabit?.name, "Noite", "Habit name should be Noite")
    }

    func test_update_habit() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        let mockHabit = HabitModel(name: "Noite", date: Date(), place: "", notes: "Teste ne paizao")
        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)

        mockHabit.name = "Manha"
        viewModel.updateHabit(habit: mockHabit)

        let firstHabit = viewModel.user.objectives?.first?.habits?.first
        XCTAssertEqual(firstHabit?.name, "Manha", "Habit name should be Noite")
    }

    func test_list_habits() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        let mockHabit = HabitModel(name: "Noite", date: Date(), place: "", notes: "Teste ne paizao")
        let mockHabit2 = HabitModel(name: "Manha", date: Date(), place: "", notes: "Dormir que sou fraco")

        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit2)

        let listHabits = viewModel.fetchHabits(for: mockObjetive)

        XCTAssertEqual(listHabits?.count, 2, "Habit count should be equal to 2")
    }
    
    func test_list_all_habits() throws {
        let mockObjetive = ObjectiveModel(name: "Testar", startDate: Date())
        let mockHabit = HabitModel(name: "Noite", date: Date(), place: "", notes: "Teste ne paizao")
        let mockHabit2 = HabitModel(name: "Manha", date: Date(), place: "", notes: "Dormir que sou fraco")

        viewModel.setUserName(name: "vitor")
        viewModel.addObjective(objective: mockObjetive)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit)
        viewModel.addHabit(to: mockObjetive, habit: mockHabit2)

        let listHabits = viewModel.fetchAllHabits()

        XCTAssertEqual(listHabits?.count, 2, "Habit count should be equal to 2")
    }

    // This test sometimes gives errors, I couldn't make it consistent
    func test_delete_habit() throws {
        let mockObjective = ObjectiveModel(name: "Testar", startDate: Date())
        let mockHabit1 = HabitModel(name: "Noite", date: Date(), place: "", notes: "Teste ne paizao")
        let mockHabit2 = HabitModel(name: "Manha", date: Date(), place: "", notes: "Dormir que sou fraco")
        let expectation = XCTestExpectation(description: "Habit added and deleted")
        
        DispatchQueue.global().async {
            self.viewModel.setUserName(name: "vitor")
            self.viewModel.addObjective(objective: mockObjective)
            
            self.viewModel.addHabit(to: mockObjective, habit: mockHabit1)
            self.viewModel.addHabit(to: mockObjective, habit: mockHabit2)
            
            DispatchQueue.main.async {
                let listHabits = self.viewModel.fetchHabits(for: mockObjective)
                
                XCTAssertEqual(listHabits?.count, 2, "Initial habit count should be equal to 2")
                
                self.viewModel.deleteHabit(id: mockHabit1.id)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let updatedListHabits = self.viewModel.fetchHabits(for: mockObjective)
                    
                    XCTAssertEqual(updatedListHabits?.count, 1, "Habit count should be equal to 1 after deletion")
                    XCTAssertEqual(updatedListHabits?.first?.name, "Manha", "First habit name should be Manha")
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
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
