
import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var category: String
    var isCompleted: Bool
    var time: String
}

struct ContentView: View {
 
    let studentName: String = "Duong Ngoc Anh Thu"

    @State private var tasks: [Task] = [
        Task(title: "Read chapter 2", category: "Study", isCompleted: false, time: "09:00"),
        Task(title: "Workout", category: "Health", isCompleted: true, time: "17:00"),
        Task(title: "Finish lab report", category: "Work", isCompleted: false, time: "20:00"),
        Task(title: "Call family", category: "Personal", isCompleted: false, time: "21:00")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ZStack(alignment: .top) {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Good Morning,")
                                    .font(.subheadline)
                                    .foregroundColor(.yellow.opacity(0.8))
                                Text(studentName)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.gray)
                                .font(.title3)
                        }
                        
                        HStack(spacing: 12) {
                            // Khối hiển thị Ngày
                            VStack(spacing: 2) {
                                Text("SEP")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 4)
                                    .background(Color.blue)
                                
                                Text("19")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 4)
                                
                                Text("2026")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 4)
                            }
                            .frame(width: 55)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                            VStack(alignment: .leading, spacing: 4) {
                                Text("“Believe you can")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                Text("and you're halfway there”")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 14)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(Color(red: 0.98, green: 0.94, blue: 0.88))
                            .cornerRadius(12)
                        }
                        .frame(height: 70)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
                .frame(height: 170)
                
                // --- 2. SECTION HEADER (My Tasks & Button) ---
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "list.bullet.clipboard.fill")
                            .foregroundColor(.blue)
                        Text("My Tasks")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        let newMockTask = Task(
                            title: "Review New Lesson",
                            category: "Study",
                            isCompleted: false,
                            time: "14:30"
                        )
                        tasks.append(newMockTask)
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("Add Task")
                                .fontWeight(.semibold)
                        }
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.13, green: 0.55, blue: 0.43))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 25)
                .padding(.bottom, 12)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(0..<tasks.count, id: \.self) { index in
                            HStack(spacing: 14) {
                                Button(action: {
                                    tasks[index].isCompleted.toggle()
                                }) {
                                    Image(systemName: tasks[index].isCompleted ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(tasks[index].isCompleted ? .blue : .gray)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(tasks[index].title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .strikethrough(tasks[index].isCompleted, color: .gray)
                                    
                                    Text(tasks[index].category)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(getCategoryColor(tasks[index].category))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(getCategoryColor(tasks[index].category).opacity(0.15))
                                        .cornerRadius(4)
                                }
                                
                                Spacer()
                                
                                Text(tasks[index].time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                Divider()
                HStack {
                    TabButton(icon: "calendar.badge.clock", label: "Today", isActive: true)
                    Spacer()
                    TabButton(icon: "chart.pie.fill", label: "Stats", isActive: false)
                    Spacer()
                    TabButton(icon: "gearshape.fill", label: "Settings", isActive: false)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .background(Color.white)
            }
        }
    }
    
    func getCategoryColor(_ category: String) -> Color {
        switch category {
        case "Study": return .blue
        case "Health": return .pink
        case "Work": return .orange
        case "Personal": return .purple
        default: return .gray
        }
    }
}

struct TabButton: View {
    let icon: String
    let label: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(label).font(.caption2)}
        .foregroundColor(isActive ? Color(red: 0.13, green: 0.55, blue: 0.43) : .gray)
    }
}
