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
    @State private var selectedObjetive: Objective?
    @State private var selectedHabit: Habit?
    @State private var showObjectiveSheet: Bool = false
    @State private var showEditObjectiveSheet: Bool = false
    @State private var showAddHabitSheet: Bool = false
    @State private var showEditHabitSheet: Bool = false
    
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
            
            ForEach(viewModel.fetchObjectives() ?? []) { objetive in
                HStack {
                    Text(objetive.name)
                        .onTapGesture {
                            selectedObjetive = objetive
                            showEditObjectiveSheet.toggle()
                        }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Spacer()
            
            HStack {
                Text("Habits List")
                    .font(.title)
                Spacer()
                Button(action: {
                    if viewModel.fetchObjectives() != [] {
                        showAddHabitSheet.toggle()
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundStyle(viewModel.fetchObjectives() != [] ? .blue : .gray)
                })
            }
            .padding(.horizontal)
            
            ForEach(viewModel.fetchAllHabtis() ?? []) { habit in
                HStack {
                    Text(habit.name)
                        .onTapGesture {
                            selectedHabit = habit
                            showEditHabitSheet.toggle()
                        }
                    Spacer()
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $showObjectiveSheet, content: {
            AddObjectiveSheet()
        })
        .sheet(item: $selectedObjetive, content: { objective in
            EditObjectiveSheet(objective: objective)
        })
        .sheet(isPresented: $showAddHabitSheet, content: {
            AddHabitSheet()
        })
        .sheet(item: $selectedHabit, content: { habit in
            EditHabitSheet(habit: habit)
        })
    }
}

//#Preview {
//    HomeView()
//}
