
import SwiftUI

struct ContentView: View {

    let studentName: String = "Duong Ngoc Anh Thu"
    let studentID: String = "SESEIU24026"
    let gpa: Double = 3.20
    let status: String = "Active"
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Text("My Partner")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                
                Spacer()
                    .frame(height: 40)
                
                HStack(spacing: 16) {
           
                    ZStack {
                        Circle()
                            .fill(Color.purple.opacity(0.2))
                            .frame(width: 70, height: 70)
                        
                        Image("account")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(studentName)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text(status)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.15))
                                .cornerRadius(8)
                        }
                        Text("Student ID: \(studentID)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.blue)
                                .font(.subheadline)
                            Text("GPA: \(String(format: "%.1f", gpa))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 32)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Keep Learning, Keep Growing ♥")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 40)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

