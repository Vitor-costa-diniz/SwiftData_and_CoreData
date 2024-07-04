//
//  AddObjetiveSheet.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 04/07/24.
//

import SwiftUI

struct AddObjetiveSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello")
            }
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
                        dismiss()
                    }, label: {
                        Text("Create")
                            .foregroundStyle(.blue)
                    })
                }
            }
        }
    }
    
}

#Preview {
    AddObjetiveSheet()
}
