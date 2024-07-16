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
    @State private var selectedObjetive: ObjectiveModel?
    @State private var selectedHabit: HabitModel?
    @State private var showObjectiveSheet: Bool = false
    @State private var showEditObjectiveSheet: Bool = false
    @State private var showAddHabitSheet: Bool = false
    @State private var showEditHabitSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: \(viewModel.user.name ?? "Nil")")
                    .font(.title3)
                Spacer()
                Text("DataBase: \(viewModel.databaseSelected.rawValue)")
                
            }
            .padding(.horizontal)
            
            TextField("User name", text: $text)
                .padding(.horizontal)
            
            HStack {
                Button(action: { 
                    viewModel.setUserName(name: text)
                    text = ""
                }, label: {
                    Text("Set name")
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(
                            Color.blue
                                .clipShape(.rect(cornerRadius: 4))
                        )
                })
                Spacer()
                Picker("Change DataBase", selection: $viewModel.databaseSelected) {
                    ForEach(DataBase.allCases, id: \.self) {
                        Text($0.name)
                            .tag($0)
                    }
                }
            }
            .onChange(of: viewModel.databaseSelected, {
                viewModel.setDataBase(viewModel.databaseSelected)
            })
            .padding(.bottom)
            .padding(.horizontal)
            
            HStack {
                Text("Objectives List")
                    .font(.title)
                Spacer()
                Button(action: { 
                    if viewModel.user.name != nil {
                        showObjectiveSheet.toggle()
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundStyle(viewModel.user.name != nil ? .blue : .gray)
                })
            }
            .padding(.horizontal)
            
            ForEach(viewModel.user.objectives ?? []) { objetive in
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
                    if viewModel.user.objectives?.count != 0 {
                        showAddHabitSheet.toggle()
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundStyle(viewModel.user.objectives?.count != 0 ? .blue : .gray)
                })
            }
            .padding(.horizontal)
            
            ForEach(viewModel.habits) { habit in
                HStack {
                    Text(habit.name)
                        .onTapGesture {
                            selectedHabit = habit
                            showEditHabitSheet.toggle()
                        }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
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

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
