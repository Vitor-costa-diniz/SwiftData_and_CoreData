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
    
    var body: some View {
        VStack {
            Text(viewModel.user.name ?? "Empty")
            TextField("User name", text: $text)
            
            Button(action: { 
                viewModel.user.name = text
                text = ""
            }, label: {
                Text("Press to set user name")
            })
        }
    }
}

//#Preview {
//    HomeView()
//}
