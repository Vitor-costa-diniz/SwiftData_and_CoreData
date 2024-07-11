//
//  AddHabitSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 04/07/24.
//

import SwiftUI

struct AddHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var date: Date = Date()
    @State var place: String = ""
    @State var notes: String = ""
    @State private var selectObjective: ObjectiveModel = ObjectiveModel(name: "", startDate: Date())
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Habit name", text: $name)
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
                
                Picker("Select Objective", selection: $selectObjective) {
                    ForEach(viewModel.fetchObjectives() ?? []) {
                        Text($0.name)
                            .tag($0)
                    }
                }
                .padding(.bottom, 24)
                
                TextField("Habit place", text: $place)
                    .background(
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 16))
                    )
                    .padding(.bottom, 24)
                
                TextField("Notes", text: $notes)
                    .background(
                        Rectangle()
                            .frame(height: 50)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 16))
                    )
                
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
                        let habit = HabitModel(name: name,
                                               date: date,
                                               place: place)
                        habit.notes = notes.isEmpty ? nil : notes
                        viewModel.addHabit(to: selectObjective, habit: habit)
                        dismiss()
                    }, label: {
                        Text("Create")
                            .foregroundStyle(name.isEmpty ? .gray : .blue)
                    })
                }
            }
        }
        .onAppear {
            if let objective = viewModel.fetchObjectives()?.first {
                selectObjective = objective
            }
        }
        .presentationDetents([.fraction(0.5)])
    }
}

#Preview {
    AddHabitSheet()
        .environmentObject(HomeViewModel())
}
