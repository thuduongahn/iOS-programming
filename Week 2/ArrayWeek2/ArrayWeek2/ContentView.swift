import SwiftUI
import Foundation

struct Computer: Identifiable {
    let id = UUID()
    var name: String
    var location: String
    var isAvailable: Bool
}
struct ContentView: View {
    @State private var computers: [Computer] = [
        Computer(name: "PC01", location: "Lab A", isAvailable: true),
        Computer(name: "PC02", location: "Lab A", isAvailable: true),
        Computer(name: "PC03", location: "Lab B", isAvailable: false),
        Computer(name: "PC04", location: "Lab B", isAvailable: true),
        Computer(name: "PC05", location: "Lab C", isAvailable: true),
    ]
    var body: some View {
        NavigationStack{
            VStack (spacing: 16) {
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("Computer Lab")
                    .font(.title2).bold()
                Text("Manage computers easily")
                    .foregroundColor(.gray)
                
                List(computers, id: \.name){ computer in
                    HStack {
                        Image (systemName: "desktopcomputer")
                            .foregroundColor(.gray)
                        VStack (alignment: .leading){
                            Text(computer.name)
                                .bold()
                            Text(computer.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        HStack(spacing: 6){
                            Image(systemName: computer.isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(computer.isAvailable ? .green : .red);
                            Text(computer.isAvailable ? "Available" : "In Use")
                                .foregroundColor(computer.isAvailable ? .green : .red)
                                .frame(width: 100, alignment: .leading)
                        }
                        Image (systemName: "chevron.right")
                    }
                }
                NavigationLink(destination: AddComputerView(computers: $computers)) {
                    Text("+ Add Computer")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                NavigationLink(destination: StatisticsView(computers: computers)) {
                    Text("View Statistics")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("Total computers: \(computers.count)")
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
            
            .padding()
        }
    }
}

struct AddComputerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var computers: [Computer]
    @State private var computerName: String = ""
    @State private var location: String = "Lab A"
    @State private var isAvailable: Bool = true
    
    var body: some View{
        NavigationStack{
            VStack (spacing: 20){
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                TextField("Enter computer name (e.g. PC06", text: $computerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter location (e.g. Lab A",text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Toggle("Available", isOn: $isAvailable)
                
                Button(action: {
                    if !computerName.isEmpty{
                        let newComputer = Computer(name: computerName, location: location, isAvailable: isAvailable)
                        computers.append(newComputer)
                        dismiss()
                    }
                }) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Add Computer")
            .navigationBarBackButtonHidden(false)
        }
    }
}
struct StatisticsView: View{
    let computers: [Computer]
    var totalCount: Int{
        computers.count
    }
    var body: some View{
            VStack(spacing: 20){
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                    .padding(.top, 10)
                
                HStack(spacing: 16){
                    Image(systemName: "desktopcomputer")
                        .font(.system(size: 28))
                        .foregroundColor(.blue)
                    VStack(alignment: .leading){
                        Text("Total Computers")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(totalCount)")
                            .font(.system(size: 28, weight: .bold))
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                List(computers) { computer in
                    HStack{
                        Image(systemName: "desktopcomputer")
                        VStack(alignment: .leading){
                            Text(computer.name)
                                .font(.headline)
                            Text(computer.location)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Circle()
                            .fill(computer.isAvailable ? .green : .red)
                            .frame(width: 10, height: 10)
                        Text(computer.isAvailable ? "Available" : "In Use")
                            .foregroundColor(computer.isAvailable ? .green : .red)
                    }
                }
                .navigationTitle("Statistics")
                .navigationBarBackButtonHidden(false)
            }
    }
}
#Preview {
    ContentView()
}
