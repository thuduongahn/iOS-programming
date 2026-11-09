

import SwiftUI

struct EquipmentManagementView: View {
    var manager: LibraryManager? // Passed if Adding, nil if Editing
    var editingItem: Equipment?  // Passed if Editing, nil if Adding
    
    @Environment(\.presentationMode) var presentationMode
    
    enum EquipType: String, CaseIterable { case laptop = "Laptop", tablet = "Tablet", camera = "Camera" }
    
    @State private var selectedType: EquipType = .laptop
    
    // Common properties
    @State private var id = ""
    @State private var name = ""
    @State private var manufacturer = ""
    @State private var purchaseYear = ""
    
    // Laptop properties
    @State private var processor = ""
    @State private var memory = ""
    @State private var storage = ""
    
    // Tablet properties
    @State private var screenSize = ""
    @State private var battery = ""
    @State private var supportsPen = false
    
    // Camera properties
    @State private var sensor = ""
    @State private var lens = ""
    @State private var video = ""
    
    @State private var errorMessage = ""
    @State private var showError = false
    
    var isEditing: Bool { editingItem != nil }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Equipment Identity")) {
                    if !isEditing {
                        Picker("Type", selection: $selectedType) {
                            ForEach(EquipType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    TextField("Equipment ID", text: $id)
                        .disabled(isEditing) // Immutable once registered
                        .foregroundColor(isEditing ? .gray : .primary)
                    
                    TextField("Name", text: $name)
                    TextField("Manufacturer", text: $manufacturer)
                    
                    TextField("Purchase Year", text: $purchaseYear)
                        .keyboardType(.numberPad)
                        .disabled(isEditing) // Immutable once registered
                        .foregroundColor(isEditing ? .gray : .primary)
                }
                
                Section(header: Text("Specific Attributes")) {
                    if selectedType == .laptop {
                        TextField("Processor", text: $processor)
                        TextField("Memory (e.g. 16GB)", text: $memory)
                        TextField("Storage Capacity", text: $storage)
                    } else if selectedType == .tablet {
                        TextField("Screen Size", text: $screenSize)
                        TextField("Battery Capacity", text: $battery)
                        Toggle("Supports Digital Pen", isOn: $supportsPen)
                    } else if selectedType == .camera {
                        TextField("Sensor Resolution", text: $sensor)
                        TextField("Lens Type", text: $lens)
                        TextField("Video Recording Capability", text: $video)
                    }
                }
                
                Button(action: saveAction) {
                    Text(isEditing ? "Update Equipment" : "Register Equipment")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .navigationTitle(isEditing ? "Edit Equipment" : "New Equipment")
            .toolbar {
                Button("Cancel") { presentationMode.wrappedValue.dismiss() }
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage))
            }
            .onAppear(perform: loadExistingData)
        }
    }
    
    func loadExistingData() {
        guard let item = editingItem else { return }
        id = item.id
        name = item.name
        manufacturer = item.manufacturer
        purchaseYear = "\(item.purchaseYear)"
        
        if let laptop = item as? Laptop {
            selectedType = .laptop
            processor = laptop.processor
            memory = laptop.memory
            storage = laptop.storageCapacity
        } else if let tablet = item as? Tablet {
            selectedType = .tablet
            screenSize = tablet.screenSize
            battery = tablet.batteryCapacity
            supportsPen = tablet.supportsPen
        } else if let camera = item as? DigitalCamera {
            selectedType = .camera
            sensor = camera.sensorResolution
            lens = camera.lensType
            video = camera.videoCapability
        }
    }
    
    func saveAction() {
        do {
            let year = Int(purchaseYear) ?? 2024
            
            if let item = editingItem {
                // Update permitted fields only
                if let laptop = item as? Laptop {
                    try laptop.updateLaptopInfo(name: name, manufacturer: manufacturer, processor: processor, memory: memory, storage: storage)
                } else if let tablet = item as? Tablet {
                    try tablet.updateTabletInfo(name: name, manufacturer: manufacturer, screenSize: screenSize, battery: battery, pen: supportsPen)
                } else if let camera = item as? DigitalCamera {
                    try camera.updateCameraInfo(name: name, manufacturer: manufacturer, sensor: sensor, lens: lens, video: video)
                }
            } else {
                // Register new equipment
                guard !id.isEmpty else { throw LibraryError.emptyFields }
                var newEq: Equipment
                
                if selectedType == .laptop {
                    newEq = Laptop(id: id, name: name, manufacturer: manufacturer, purchaseYear: year, processor: processor, memory: memory, storageCapacity: storage)
                } else if selectedType == .tablet {
                    newEq = Tablet(id: id, name: name, manufacturer: manufacturer, purchaseYear: year, screenSize: screenSize, batteryCapacity: battery, supportsPen: supportsPen)
                } else {
                    newEq = DigitalCamera(id: id, name: name, manufacturer: manufacturer, purchaseYear: year, sensorResolution: sensor, lensType: lens, videoCapability: video)
                }
                try manager?.registerEquipment(newEq)
            }
            
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
