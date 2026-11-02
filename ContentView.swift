//
//  ContentView.swift
//  Library Resource Management
//
//  Created by MAY 07 on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.resources) { resource in
                NavigationLink(destination: ResourceDetailView(resource: resource)) {
                    VStack(alignment: .leading) {
                        Text(resource.title).font(.headline)
                        Text(resource.isAvailable ? "Available" : "Unavailable")
                            .font(.subheadline)
                            .foregroundColor(resource.isAvailable ? .green : .red)
                    }
                }
            }
            .navigationTitle("Library Resources")
        }
    }
}

// Detail View
struct ResourceDetailView: View {
    @ObservedObject var resource: LibraryResource
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(resource.title)
                .font(.title)
                .bold()
            
            // Type casting to display subclass-specific information
            if let book = resource as? PrintedBook {
                Text("Type: Printed Book")
                Text("Author: \(book.author)")
                Text("ISBN: \(book.isbn)")
            } else if let journal = resource as? AcademicJournal {
                Text("Type: Academic Journal")
                Text("Volume: \(journal.volume), Issue: \(journal.issue)")
                Text(journal.canBorrow ? "Status: Can be borrowed" : "Status: Reference Only")
            } else if let digital = resource as? DigitalMaterial {
                Text("Type: Digital Material")
                Text("Platform: \(digital.platform)")
                Text("Users: \(digital.currentUsers) / \(digital.maxUsers)")
            }
            
            Text("Base Fee: $\(String(format: "%.2f", resource.baseFee))")
            
            Spacer()
            
            HStack {
                Button(action: handleBorrow) {
                    Text(resource is DigitalMaterial ? "Access" : "Borrow")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: handleReturn) {
                    Text("Return")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func handleBorrow() {
        do {
            let fee = try resource.requestAccess()
            alertTitle = "Success"
            alertMessage = fee > 0 ? "Successfully borrowed. Applicable fee: $\(String(format: "%.2f", fee))" : "Free access granted successfully."
            showingAlert = true
        } catch let error as LibraryError {
            // Display rejected invalid operation error
            alertTitle = "Operation Error"
            alertMessage = error.localizedDescription
            showingAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = "An unknown error occurred."
            showingAlert = true
        }
    }
    
    private func handleReturn() {
        resource.returnResource()
        alertTitle = "Notification"
        alertMessage = "Resource returned successfully."
        showingAlert = true
    }
}

// App Entry Point
@main
struct LibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
