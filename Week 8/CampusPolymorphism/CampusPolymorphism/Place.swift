//
//  Place.swift
//  CampusPolymorphism
//
//  Created by May06 on 16/11/26.
//

import Foundation
class CampusPlace{
    let name: String
    init(name: String) {self.name = name}
    func visitMessage() -> String{
        "Visiting \(name)"
    }
}
class Classroom: CampusPlace{
    override func visitMessage() -> String {
        "Attend a lesson at \(name)"
    }
}
class Library: CampusPlace{
    override func visitMessage() -> String {
        "Read books at \(name)"
    }
}
class Laboratory: CampusPlace{
    override func visitMessage() -> String {
        "Conduct an experiment at \(name)"
    }
}
class Cafeteria: CampusPlace{
    override func visitMessage() -> String {
        "Have a break at \(name)"
    }
}
class Canteen: CampusPlace{
    override func visitMessage() -> String {
        "Have a meal at \(name)"
    }
}
struct Coordinate {
    let latitude: Double
    let longitude: Double
}
protocol LocationProvider{
    func currentLocation() -> Coordinate?
}
class MockLocationProvider: LocationProvider{
    func currentLocation() -> Coordinate?{
        Coordinate(latitude: 10.8705, longitude: 106.8039)
}
}
class UnavailableLocationProvider: LocationProvider {
    func currentLocation() -> Coordinate? {
        return nil
    }
}

class AlternateLocationProvider: LocationProvider {
    func currentLocation() -> Coordinate? {
        return Coordinate(latitude: 21.0285, longitude: 105.8542)
    }
}

class LocationController {
    private let provider: any LocationProvider
    
    init(provider: any LocationProvider) {
        self.provider = provider
    }
    
    func showLocation() {
        guard let location = provider.currentLocation() else {
            print("Location unavailable")
            return
        }
        print("Lat: \(location.latitude), Lon: \(location.longitude)")
    }
}
