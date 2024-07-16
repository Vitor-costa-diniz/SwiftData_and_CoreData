//
//  AppTabBar.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import SwiftUI

struct AppTabBar: View {
    @State private var tabBarSelection: Int = 0
    @Environment(\.modelContext) var context
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        TabView(selection: $tabBarSelection) {
            HomeView()
                .environmentObject(homeViewModel)
                .tag(0)
                .tabItem {
                    Label(
                        title: { Text("List") },
                        icon: { Image(systemName: "house") }
                    )
                }
            
            Text("Testing")
                .tag(1)
                .tabItem {
                    Label(
                        title: { Text("Add") },
                        icon: { Image(systemName: "plus") }
                    )
                }
        }
        .onAppear {
            homeViewModel.setContext(context)
        }
        .tint(.blue)
    }
}

#Preview {
    AppTabBar()
        .modelContainer(for: UserSwiftData.self)
}

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.backgroundColor = UIColor(.blue.opacity(0.1))
        view.bringSubviewToFront(tabBar)
    }
}
