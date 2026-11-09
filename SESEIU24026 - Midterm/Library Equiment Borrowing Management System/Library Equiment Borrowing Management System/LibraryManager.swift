//
//  LibraryManager.swift
//  Library Equiment Borrowing Management System
//
//  Created by SEIU iMac 5 on 09/11/2026.
//

import SwiftUI

class LibraryManager: ObservableObject {
    @Published var equipments: [Equipment] = []
    
    init() {
        // Local sample data
        equipments.append(Laptop(id: "L01", name: "MacBook Pro M2", manufacturer: "Apple", purchaseYear: 2023, processor: "M2", memory: "16GB", storageCapacity: "512GB"))
        equipments.append(Tablet(id: "T01", name: "iPad Air 5", manufacturer: "Apple", purchaseYear: 2022, screenSize: "10.9 inch", batteryCapacity: "7600 mAh", supportsPen: true))
        equipments.append(DigitalCamera(id: "C01", name: "Alpha a7 IV", manufacturer: "Sony", purchaseYear: 2024, sensorResolution: "33 MP", lensType: "Interchangeable", videoCapability: "4K 60fps"))
        equipments.append(Laptop(id: "L02", name: "Dell XPS 15", manufacturer: "Dell", purchaseYear: 2023, processor: "Intel Core i7", memory: "32GB", storageCapacity: "1TB"))
        equipments.append(Tablet(id: "T02", name: "Galaxy Tab S9", manufacturer: "Samsung", purchaseYear: 2023, screenSize: "11 inch", batteryCapacity: "8400 mAh", supportsPen: true))
    }
    
    func registerEquipment(_ newEquipment: Equipment) throws {
        if equipments.contains(where: { $0.id == newEquipment.id }) {
            throw LibraryError.duplicateID
        }
        equipments.append(newEquipment)
    }
}
