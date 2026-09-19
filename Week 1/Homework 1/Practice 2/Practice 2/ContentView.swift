
import SwiftUI

struct ContentView: View {
  
    let studentName: String = "Duong Ngoc Anh Thu"
    let studentID: String = "SESEIU24026"
    let age: Int = 18
    let gpa: Double = 3.20
    let isStudent: Bool = true
    let motto: String = "Better me, a brighter tomorrow!"
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ZStack(alignment: .top) {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                      
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding()
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Small Steps")
                            Text("Big Dreams ♥")
                        }
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(.white.opacity(0.9))
                        .padding()
                        Spacer()
                    }
                    .padding(.top, 10)
                   
                    Image("account")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 4)
                        .offset(y: 125)
                }
                .frame(height: 180)
                
                Spacer().frame(height: 50)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        
                        VStack(spacing: 4) {
                            Text(studentName)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("Always learning, always growing ♡")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 5)
                        
                        VStack(spacing: 12) {
    
                            HStack(spacing: 12) {
                                InfoCard(icon: "person.text.rectangle.fill", iconColor: .blue, title: "Student ID", value: studentID)
                                InfoCard(icon: "birthday.cake.fill", iconColor: .pink, title: "Age", value: "\(age)")
                            }
                            
                            HStack(spacing: 12) {
                                InfoCard(icon: "chart.bar.fill", iconColor: .green, title: "GPA", value: String(format: "%.1f", gpa))
                                InfoCard(icon: "graduationcap.fill", iconColor: .purple, title: "Student", value: isStudent ? "true" : "false")
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("“")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text(motto)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        
                        Button(action: {
                        }) {
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                Text("Edit Profile")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(red: 0.13, green: 0.55, blue: 0.43))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 5)
                    }
                    .padding(.bottom, 20)
                }
                
                Spacer()
              
                Divider()
                HStack {
                    TabItem(icon: "person.fill", label: "Profile", isActive: true)
                    Spacer()
                    TabItem(icon: "book.closed.fill", label: "Subjects", isActive: false)
                    Spacer()
                    TabItem(icon: "gearshape.fill", label: "Settings", isActive: false)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .background(Color.white)
            }
        }
    }
}

struct InfoCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(iconColor)
                .frame(width: 36, height: 36)
                .background(iconColor.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                Text(value)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}


struct TabItem: View {
    let icon: String
    let label: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(label)
                .font(.caption2)
        }
        .foregroundColor(isActive ? Color(red: 0.13, green: 0.55, blue: 0.43) : .gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
