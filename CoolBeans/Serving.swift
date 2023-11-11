//
//  Serving.swift
//  CoolBeans
//
//  Created by Tal talspektor on 11/11/2023.
//

import Foundation

struct Serving: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
