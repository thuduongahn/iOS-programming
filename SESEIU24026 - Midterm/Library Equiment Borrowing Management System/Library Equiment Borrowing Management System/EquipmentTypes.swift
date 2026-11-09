//
//  EquipmentTypes.swift
//  Library Equiment Borrowing Management System
//
//  Created by SEIU iMac 5 on 09/11/2026.
//
import Foundation

class Laptop: Equipment {
    @Published private(set) var processor: String
    @Published private(set) var memory: String
    @Published private(set) var storageCapacity: String
    
    init(id: String, name: String, manufacturer: String, purchaseYear: Int, processor: String, memory: String, storageCapacity: String) {
        self.processor = processor
        self.memory = memory
        self.storageCapacity = storageCapacity
        super.init(id: id, name: name, manufacturer: manufacturer, purchaseYear: purchaseYear)
    }
    
    func updateLaptopInfo(name: String, manufacturer: String, processor: String, memory: String, storage: String) throws {
        try super.updateCommonInfo(name: name, manufacturer: manufacturer)
        guard !processor.isEmpty, !memory.isEmpty, !storage.isEmpty else { throw LibraryError.emptyFields }
        self.processor = processor
        self.memory = memory
        self.storageCapacity = storage
    }
}

class Tablet: Equipment {
    @Published private(set) var screenSize: String
    @Published private(set) var batteryCapacity: String
    @Published private(set) var supportsPen: Bool
    
    init(id: String, name: String, manufacturer: String, purchaseYear: Int, screenSize: String, batteryCapacity: String, supportsPen: Bool) {
        self.screenSize = screenSize
        self.batteryCapacity = batteryCapacity
        self.supportsPen = supportsPen
        super.init(id: id, name: name, manufacturer: manufacturer, purchaseYear: purchaseYear)
    }
    
    func updateTabletInfo(name: String, manufacturer: String, screenSize: String, battery: String, pen: Bool) throws {
        try super.updateCommonInfo(name: name, manufacturer: manufacturer)
        guard !screenSize.isEmpty, !battery.isEmpty else { throw LibraryError.emptyFields }
        self.screenSize = screenSize
        self.batteryCapacity = battery
        self.supportsPen = pen
    }
}

class DigitalCamera: Equipment {
    @Published private(set) var sensorResolution: String
    @Published private(set) var lensType: String
    @Published private(set) var videoCapability: String
    
    init(id: String, name: String, manufacturer: String, purchaseYear: Int, sensorResolution: String, lensType: String, videoCapability: String) {
        self.sensorResolution = sensorResolution
        self.lensType = lensType
        self.videoCapability = videoCapability
        super.init(id: id, name: name, manufacturer: manufacturer, purchaseYear: purchaseYear)
    }
    
    func updateCameraInfo(name: String, manufacturer: String, sensor: String, lens: String, video: String) throws {
        try super.updateCommonInfo(name: name, manufacturer: manufacturer)
        guard !sensor.isEmpty, !lens.isEmpty, !video.isEmpty else { throw LibraryError.emptyFields }
        self.sensorResolution = sensor
        self.lensType = lens
        self.videoCapability = video
    }
}
