//
//  SwiftDataCoreDataApp.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            AppTabBar()
                .modelContainer(for: UserSwiftData.self)
        }
    }
}
