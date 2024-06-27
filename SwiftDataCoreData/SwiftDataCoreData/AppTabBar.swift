//
//  AppTabBar.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import SwiftUI

struct AppTabBar: View {
    @State private var tabBarSelection: Int = 0
    var body: some View {
        TabView(selection: $tabBarSelection) {
            Text("Testing")
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
        .tint(.blue)
    }
}

#Preview {
    AppTabBar()
}

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.backgroundColor = UIColor(.blue.opacity(0.1))
        view.bringSubviewToFront(tabBar)
    }
}
