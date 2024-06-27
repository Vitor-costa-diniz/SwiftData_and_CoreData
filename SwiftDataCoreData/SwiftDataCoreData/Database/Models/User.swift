//
//  User.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 27/06/24.
//

import Foundation

import SwiftData

@Model
class User {
    var name: String?
    var tomatos: Int?
    @Relationship(deleteRule: .cascade) var objectives: [Objective]?
    
    init(name: String? = nil,
         tomatos: Int? = nil,
         objectives: [Objective]? = nil) {
        self.name = name
        self.tomatos = tomatos
        self.objectives = objectives
    }
}
