//
//  EquipmentDetailView.swift
//  Library Equiment Borrowing Management System
//
//  Created by SEIU iMac 5 on 09/11/2026.
//

import SwiftUI

struct EquipmentDetailView: View {
    @ObservedObject var item: Equipment
    
    @State private var showingEditScreen = false
    @State private var showingBorrowSheet = false
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section(header: Text("Common Information")) {
                DetailRow(title: "ID", value: item.id)
                DetailRow(title: "Name", value: item.name)
                DetailRow(title: "Manufacturer", value: item.manufacturer)
                DetailRow(title: "Purchase Year", value: "\(item.purchaseYear)")
                DetailRow(title: "Status", value: item.status.rawValue)
            }
            
            if let laptop = item as? Laptop {
                Section(header: Text("Laptop Specifications")) {
                    DetailRow(title: "Processor", value: laptop.processor)
                    DetailRow(title: "Memory", value: laptop.memory)
                    DetailRow(title: "Storage", value: laptop.storageCapacity)
                }
            } else if let tablet = item as? Tablet {
                Section(header: Text("Tablet Specifications")) {
                    DetailRow(title: "Screen Size", value: tablet.screenSize)
                    DetailRow(title: "Battery", value: tablet.batteryCapacity)
                    DetailRow(title: "Supports Pen", value: tablet.supportsPen ? "Yes" : "No")
                }
            } else if let camera = item as? DigitalCamera {
                Section(header: Text("Camera Specifications")) {
                    DetailRow(title: "Sensor", value: camera.sensorResolution)
                    DetailRow(title: "Lens", value: camera.lensType)
                    DetailRow(title: "Video", value: camera.videoCapability)
                }
            }
         
                        if item.status != .available {
                            Section(header: Text("Borrowing Transaction")) {
                                DetailRow(title: "Borrower", value: item.borrowerName ?? "")
                                DetailRow(title: "Borrow Date", value: formatDate(item.borrowDate))
                                DetailRow(title: "Expected Return", value: formatDate(item.expectedReturnDate))
                            }
                        }
                        
                        Section {
                            Button("Borrow Equipment") {
                        
                                if item.status != .available {
                                    triggerError(LibraryError.alreadyBorrowed)
                                } else {
                                    showingBorrowSheet = true
                                }
                            }
                            .foregroundColor(.blue)
                            
                            Button("Return Equipment") {
                                do {
                                    try item.returnEquipment()
                                    alertMessage = "Equipment returned successfully!"
                                    showingAlert = true
                                } catch {
                                    triggerError(error)
                                }
                            }
                            .foregroundColor(.orange)
                        }
        }
        .navigationTitle(item.name)
        .toolbar {
            Button("Edit") { showingEditScreen = true }
        }
        .sheet(isPresented: $showingEditScreen) {
            EquipmentManagementView(manager: nil, editingItem: item)
        }
        .sheet(isPresented: $showingBorrowSheet) {
            BorrowSheet(item: item)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("System Message"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func triggerError(_ error: Error) {
        alertMessage = error.localizedDescription
        showingAlert = true
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text(title).fontWeight(.bold)
            Spacer()
            Text(value).foregroundColor(.secondary)
        }
    }
}
