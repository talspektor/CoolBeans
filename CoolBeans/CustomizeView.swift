//
//  CostomizeView.swift
//  CoolBeans
//
//  Created by Tal talspektor on 11/11/2023.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink

    @State private var size = 0
    @State private var isDecaf = false

    let sizeOptions = ["Small", "Medium", "Large"]

    var coffeine: Int {
        100
    }

    var calories: Int {
        100
    }

    var body: some View {
        Form {
            Section("Basic options") {
                Picker("Size", selection: $size) {
                    ForEach(sizeOptions.indices) { index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)

                Toggle("Decaffeinated", isOn: $isDecaf)
            }

            Section("Estimates") {
                Text("**Caffiene:** \(coffeine)mg")
                Text("**Calories:** \(calories)mg")
            }
        }
    }
}

#Preview {
    CustomizeView(drink: Drink.example)
}
