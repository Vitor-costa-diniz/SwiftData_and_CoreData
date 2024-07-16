//
//  EditHabitSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 05/07/24.
//

import SwiftUI

struct EditHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    var habit: HabitModel
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var place: String = ""
    @State var notes: String = ""
    @State private var selectObjective: ObjectiveModel = ObjectiveModel(name: "", startDate: Date())
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Habit name", text: $name)
                    .padding(.leading)
                    .background(
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 16))
                    )
                    .padding(.bottom, 24)
                
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Select a date")
                }
                .padding(.bottom, 24)
                
                TextField("Habit place", text: $place)
                    .padding(.leading)
                    .background(
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 16))
                    )
                    .padding(.bottom, 24)
                
                TextField("Notes", text: $notes)
                    .padding(.leading)
                    .background(
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 16))
                    )
                    .padding(.bottom, 32)
                
                Button(action: {
                    viewModel.deleteHabit(id: habit.id)
                    dismiss()
                }, label: {
                    Text("Delete Habit")
                        .foregroundStyle(.white)
                        .background(
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: 200, height: 40)
                                .clipShape(.rect(cornerRadius: 8))
                        )
                })
                
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text("New Habit")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        let habitModel = habit
                        habitModel.name = name
                        habitModel.place = place
                        habitModel.date = date
                        habitModel.notes = notes.isEmpty ? nil : notes
                        viewModel.updateHabit(habit: habitModel)
                        dismiss()
                    }, label: {
                        Text("Edit")
                            .foregroundStyle(name.isEmpty ? .gray : .blue)
                    })
                }
            }
        }
        .onAppear {
            name = habit.name
            place = habit.place
            date = habit.date
            notes = habit.notes ?? ""
        }
        .presentationDetents([.fraction(0.7)])
    }
}

#Preview {
    EditHabitSheet(habit: HabitModel(name: "", date: Date(), place: ""))
        .environmentObject(HomeViewModel())
}
