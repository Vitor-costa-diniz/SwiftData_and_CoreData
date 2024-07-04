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
    @State private var showObjectiveSheet: Bool = false
    
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
            
            ForEach(viewModel.user.objectives ?? []) {
                Text($0.name)
            }
            Spacer()
        }
        .sheet(isPresented: $showObjectiveSheet, content: {
            AddObjectiveSheet()
        })
    }
}

//#Preview {
//    HomeView()
//}
