import SwiftUI

struct MainTabView: View {
 
    @StateObject private var manager = LibraryManager()
    
    var body: some View {
        TabView {
            EquipmentListView(manager: manager)
                .tabItem {
                    Label("Equipment", systemImage: "laptopcomputer.and.ipad")
                }
            
            BorrowingsView(manager: manager)
                .tabItem {
                    Label("Borrowings", systemImage: "arrow.left.arrow.right")
                }
            
            ManageEquipmentView(manager: manager)
                .tabItem {
                    Label("Manage", systemImage: "gearshape")
                }
        }
    }
}
struct BorrowingsView: View {
    @ObservedObject var manager: LibraryManager
    
    var body: some View {
        NavigationView {
            Text("Borrowing management here.")
                .foregroundColor(.secondary)
                .navigationTitle("Borrowings")
        }
    }
}

struct ManageEquipmentView: View {
    @ObservedObject var manager: LibraryManager
    
    @State private var showingRegisterScreen = false
    @State private var selectedItemToUpdate: Equipment?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button(action: { showingRegisterScreen = true }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Register New Equipment")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section(header: Text("Update Existing Equipment")) {
                    ForEach(manager.equipments) { item in
                        Button(action: { selectedItemToUpdate = item }) {
                            HStack {
                                Text(item.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("ID: \(item.id)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Manage Equipment")
            .sheet(isPresented: $showingRegisterScreen) {
                EquipmentManagementView(manager: manager)
            }
            .sheet(item: $selectedItemToUpdate) { item in
                EquipmentManagementView(manager: nil, editingItem: item)
            }
        }
    }
}
