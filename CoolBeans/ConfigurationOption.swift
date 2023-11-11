//
//  ConfigurationOption.swift
//  CoolBeans
//
//  Created by Tal talspektor on 11/11/2023.
//

import Foundation

struct ConfigurationOption: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let calories: Int

    static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
}
