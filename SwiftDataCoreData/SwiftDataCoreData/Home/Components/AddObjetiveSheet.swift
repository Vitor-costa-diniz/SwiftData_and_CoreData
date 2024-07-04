//
//  AddObjetiveSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 04/07/24.
//

import SwiftUI

struct AddObjetiveSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var date: Date = Date()
    @State var notes: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Objetive name", text: $name)
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
                        name = ""
                        notes = ""
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
                        dismiss()
                        name = ""
                        notes = ""
                    }, label: {
                        Text("Create")
                            .foregroundStyle(name.isEmpty ? .gray : .blue)
                    })
                }
            }
        }
        .presentationDetents([.fraction(0.3)])
    }
    
}

#Preview {
    AddObjetiveSheet()
}