//
//  HomeView.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 03/07/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var text: String = ""
    @State private var selectedObjetive: Objective = Objective(name: "", startDate: Date())
    @State private var showObjectiveSheet: Bool = false
    @State private var showEditObjectiveSheet: Bool = false
    
    var body: some View {
        VStack {
            Text(viewModel.user.name ?? "Empty")
            
            TextField("User name", text: $text)
                .padding(.horizontal)
            
            Button(action: { 
                viewModel.setUserName(name: text)
                text = ""
            }, label: {
                Text("Press to set user name")
            })
            .padding(.bottom)
            
            HStack {
                Text("Objectives List")
                    .font(.title)
                Spacer()
                Button(action: { showObjectiveSheet.toggle() }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding(.horizontal)
            
            ForEach(viewModel.user.objectives ?? []) { objetive in
                Text(objetive.name)
                    .onTapGesture {
                        selectedObjetive = objetive
                        showEditObjectiveSheet.toggle()
                    }
            }
            .padding(.bottom)
            
            Spacer()
            
            Text("Habits List")
                .font(.title)
            
            Spacer()
        }
        .sheet(isPresented: $showObjectiveSheet, content: {
            AddObjectiveSheet()
        })
        .sheet(isPresented: $showEditObjectiveSheet, onDismiss: {
            selectedObjetive = Objective(name: "", startDate: Date())
        }, content: {
            EditObjectiveSheet(objective: selectedObjetive)
        })
    }
}

//#Preview {
//    HomeView()
//}
