//
//  AddObjectiveSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 04/07/24.
//

import SwiftUI

struct AddObjectiveSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var objective: Objective = Objective(name: "", startDate: Date())
    @State var notes: String = ""
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Objetive name", text: $objective.name)
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
                    Text("New Objective")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        objective.notes = notes.isEmpty ? nil : notes
                        viewModel.addObjective(objective: objective)
                        dismiss()
                    }, label: {
                        Text("Create")
                            .foregroundStyle(objective.name.isEmpty ? .gray : .blue)
                    })
                }
            }
        }
        .presentationDetents([.fraction(0.3)])
    }
}

#Preview {
    AddObjectiveSheet()
}
