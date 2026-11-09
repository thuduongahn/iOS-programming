

import SwiftUI

struct EquipmentListView: View {
    @ObservedObject var manager: LibraryManager
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                Text("Manange equipment and borrowing")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
           
            List(manager.equipments) { item in
                NavigationLink(destination: EquipmentDetailView(item: item)) {
                    EquipmentRow(item: item)
                }
            }
        }
            .navigationTitle("Library Equipment")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddScreen = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                EquipmentManagementView(manager: manager)
            }
        }
    }
}

struct EquipmentRow: View {
    @ObservedObject var item: Equipment
    
    var body: some View {
        HStack(spacing: 16) {
            Image(imageName(for: item))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.1), radius: 3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name).font(.headline)
                Text(itemType(for: item)).font(.subheadline).foregroundColor(.secondary)
                Text(item.status.rawValue)
                    .font(.caption)
                    .bold()
                    .foregroundColor(statusColor(for: item.status))
            }
        }
        .padding(.vertical, 4)
    }
    
    func itemType(for item: Equipment) -> String {
        if item is Laptop { return "Laptop" }
        if item is Tablet { return "Tablet" }
        if item is DigitalCamera { return "Digital Camera" }
        return "Equipment"
    }
    
    func imageName(for item: Equipment) -> String {
        switch item.id {
        case "L01": return "MacbookProM2"
        case "L02": return "dellXPS15"
        case "T01": return "ipadAir5"
        case "T02": return "galaxytabS9"
        case "C01": return "alphaA7IV"
        default:
            if item is Laptop { return "MacbookProM2" }
            if item is Tablet { return "ipadAir5" }
            return "alphaA7IV"
        }
    }
    
    func statusColor(for status: EquipmentStatus) -> Color {
        switch status {
        case .available: return .green
        case .borrowed: return .orange
        case .loan: return .red
        }
    }
}
