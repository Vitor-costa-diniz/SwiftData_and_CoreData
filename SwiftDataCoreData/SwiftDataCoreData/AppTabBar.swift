//
//  AppTabBar.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import SwiftUI

struct AppTabBar: View {
    @Environment(\.modelContext) var context
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        HomeView()
            .environmentObject(homeViewModel)
            .onAppear {
                homeViewModel.setContext(context)
            }
    }
}

#Preview {
    AppTabBar()
        .modelContainer(for: UserSwiftData.self)
}

//extension UITabBarController {
//    open override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        tabBar.backgroundColor = UIColor(.blue.opacity(0.1))
//        view.bringSubviewToFront(tabBar)
//    }
//}
