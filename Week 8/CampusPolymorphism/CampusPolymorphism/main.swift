//
//  main.swift
//  CampusPolymorphism
//
//  Created by May06 on 16/11/26.
//

import Foundation
print("--- TASK 4: POLYMORPHISM OUTPUT ---")
let places: [CampusPlace] = [
    Classroom(name: "Room A101"),
    Library(name: "Central Library"),
    Laboratory(name: "Physics Lab"),
    Cafeteria(name: "Coffee Story"),
    Canteen(name: "IU Canteen")
]

for place in places {
    print(place.visitMessage())
}


print("\n--- TASK 5: DEPENDENCY INJECTION OUTPUT ---")

let demo = LocationController(provider: MockLocationProvider())
print("Mock Provider: ", terminator: "")
demo.showLocation()

let offline = LocationController(provider: UnavailableLocationProvider())
print("Offline Provider: ", terminator: "")
offline.showLocation()

let alternate = LocationController(provider: AlternateLocationProvider())
print("Alternate Provider: ", terminator: "")
alternate.showLocation()
