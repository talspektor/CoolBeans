//
//  CostomizeView.swift
//  CoolBeans
//
//  Created by Tal talspektor on 11/11/2023.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    let dismiss: () -> Void

    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History

    @State private var size = 0
    @State private var isDecaf = false
    @State private var extraShots = 0
    @State private var milk = ConfigurationOption.none
    @State private var syrup = ConfigurationOption.none

    @State private var isFirstAppearance = true

    let sizeOptions = ["Small", "Medium", "Large"]

    var caffeine: Int {
        var caffeineAmount = drink.caffeine[size]
        caffeineAmount += (extraShots * 60)

        if isDecaf {
            caffeineAmount /= 20
        }

        return caffeineAmount
    }

    var calories: Int {
        var caloryAmount = drink.baseCalories
        caloryAmount += extraShots * 10

        if drink.coffeeBased {
            caloryAmount += milk.calories
        } else {
            caloryAmount += milk.calories / 8
        }

        caloryAmount += syrup.calories
        return caloryAmount * (size + 1)
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

                if drink.coffeeBased {
                    Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
                }

                Toggle("Decaffeinated", isOn: $isDecaf)
            }

            Section("Costomixations") {
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }

                if drink.coffeeBased {
                    Picker("Syrup", selection: $syrup) {
                        ForEach(menu.syrupOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            }

            Section("Estimates") {
                Text("**Caffiene:** \(caffeine)mg")
                Text("**Calories:** \(calories)mg")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar {
            Button("Save") {
                history.add(
                    drink,
                    size: sizeOptions[size],
                    extraShota: extraShots,
                    isDecaf: isDecaf,
                    milk: milk,
                    syrup: syrup,
                    caffeine: caffeine,
                    calories: calories
                )

                dismiss()
            }
        }
        onAppear {
            guard isFirstAppearance else { return }

            if drink.servedWithMilk {
                milk = menu.milkOptions[1]
            }

            isFirstAppearance = false
        }
    }
}

#Preview {
    CustomizeView(drink: Drink.example) { }
        .environmentObject(Menu())
}
