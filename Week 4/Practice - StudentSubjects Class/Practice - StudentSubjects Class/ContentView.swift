import SwiftUI

class StudentSubjects {
    private var studentId: String
    private var courseId: String
    private var year: Int
    private var mark: Double
    
    init() {
        self.studentId = ""
        self.courseId = ""
        self.year = 0
        self.mark = 0.0
    }
    
    init(studentId: String) {
        self.studentId = studentId
        self.courseId = ""
        self.year = 0
        self.mark = 0.0
    }
    
    init(studentId: String, courseId: String) {
        self.studentId = studentId
        self.courseId = courseId
        self.year = 0
        self.mark = 0.0
    }
    
    init(studentId: String, courseId: String, year: Int, mark: Double) {
        self.studentId = studentId
        self.courseId = courseId
        self.year = year
        self.mark = mark
    }
    
    func getStudentId() -> String { return studentId }
    func getCourseId() -> String { return courseId }
    func getYear() -> Int { return year }
    func getMark() -> Double { return mark }
    
                    
    func setStudentId(_ newId: String) { studentId = newId }
    func setCourseId(_ newCourseId: String) { courseId = newCourseId }
    func setYear(_ newYear: Int) { year = newYear }
    func setMark(_ newMark: Double) { mark = newMark }
    
                
    func displayInfo() -> String {
        return "Student: \(studentId), Course: \(courseId), Year: \(year), Mark: \(mark)"
    }
}

struct ContentView: View {
    @State private var outputText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(outputText)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black)
                .cornerRadius(10)
                .padding()
            
            Spacer()
        }
        .onAppear {
            runMainLogic()
        }
    }
    
    func runMainLogic() {
        var log = "StudentSubjects Class Example\n"
        log += "-----------------------------\n"
        
        let r1 = StudentSubjects()
        let r2 = StudentSubjects(studentId: "SV001")
        let r3 = StudentSubjects(studentId: "SV002", courseId: "CSE101")
        let r4 = StudentSubjects(studentId: "SV003", courseId: "CSE201", year: 2024, mark: 8.5)
        
        r1.setStudentId("SV004")
        r1.setCourseId("CSE101")
        r1.setYear(2024)
        r1.setMark(9.0)
        
        log += r1.displayInfo() + "\n"
        log += r2.displayInfo() + "\n"
        log += r3.displayInfo() + "\n"
        log += r4.displayInfo() + "\n"
        
        outputText = log
    }
}
