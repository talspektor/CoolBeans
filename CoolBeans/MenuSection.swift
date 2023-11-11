//
//  MenuSection.swift
//  CoolBeans
//
//  Created by Tal talspektor on 11/11/2023.
//

import Foundation

struct MenuSection: Identifiable, Codable {
    let id: UUID
    let name: String
    let drinks: [Drink]

    func matches(for search: String) -> [Drink] {
        let trimmed = search.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty { return drinks }

        return drinks.filter { $0.name.localizedStandardContains(trimmed) }
    }
}
