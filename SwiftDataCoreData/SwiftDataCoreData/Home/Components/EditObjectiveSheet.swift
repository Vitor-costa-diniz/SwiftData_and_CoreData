//
//  EditObjectiveSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 04/07/24.
//

import SwiftUI

struct EditObjectiveSheet: View {
    @Environment(\.dismiss) var dismiss
    var objective: ObjectiveModel
    @State private var name: String = ""
    @State private var notes: String = ""
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Objetive name", text: $name)
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
                    viewModel.deleteObjective(objective: objective)
                    dismiss()
                }, label: {
                    Text("Delete Objective")
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
            .onAppear {
                name = objective.name
                notes = objective.notes ?? ""
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
                    Text("Edit Objective")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        let objectiveModel = objective
                        objectiveModel.name = name
                        objectiveModel.notes = notes.isEmpty ? nil : notes
                        viewModel.updateObjective(objective: objectiveModel)
                        dismiss()
                    }, label: {
                        Text("Edit")
                            .foregroundStyle(name.isEmpty ? .gray : .blue)
                    })
                }
            }
        }
        .presentationDetents([.fraction(0.5)])
    }
}

#Preview {
    EditObjectiveSheet(objective: ObjectiveModel(name: "", startDate: Date()))
}
