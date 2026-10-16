import SwiftUI

class Student {
    private var id: String
    private var name: String
    private var year: Int
    private var gpa: Double
    
    init(id: String, name: String, year: Int, gpa: Double) {
        self.id = id
        self.name = name
        self.year = year
        self.gpa = gpa
    }
    
    func getId() -> String { return id }
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name), Year: \(year), GPA: \(gpa)"
    }
}

class Subject {
    private var id: String
    private var name: String
    private var credits: Int
    private var semester: Int
    
    init(id: String, name: String, credits: Int, semester: Int) {
        self.id = id
        self.name = name
        self.credits = credits
        self.semester = semester
    }
    
    func getId() -> String { return id }
    func getName() -> String { return name }
    func displayInfo() -> String {
        return "[\(id)] \(name) (Credits: \(credits), Semester: \(semester))"
    }
}

class Teacher {
    private var id: String
    private var name: String
    private var subjects: [Subject]
    private var department: String
    
    init(id: String, name: String, subjects: [Subject], department: String) {
        self.id = id
        self.name = name
        self.subjects = subjects
        self.department = department
    }
    
    func displayInfo() -> String {
        var info = "ID: \(id), Name: \(name), Department: \(department)\n"
        info += "Subjects:\n"
        for subject in subjects {
            info += "- \(subject.displayInfo())\n"
        }
        return info
    }
}

class StudentSubject {
    private var studentId: String
    private var subjectId: String
    private var year: Int
    private var mark: Double
    
    init(studentId: String, subjectId: String, year: Int, mark: Double) {
        self.studentId = studentId
        self.subjectId = subjectId
        self.year = year
        self.mark = mark
    }
    
    func displayInfo() -> String {
        return "\(studentId) - \(subjectId) - Year: \(year), Mark: \(mark)"
    }
}


struct ContentView: View {
    @State private var outputText: String = ""
    
    var body: some View {
        ScrollView {
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
        }
        .onAppear {
            runMainLogic()
        }
    }
    
    func runMainLogic() {
        var log = ""
        log += "--- School Management System (2026 - 2027) ---\n"
        log += "*** Teachers ***\n"
        
       
        let s1 = Subject(id: "CSE101", name: "iOS Programming", credits: 3, semester: 1)
        let s2 = Subject(id: "CSE201", name: "Data Structures", credits: 4, semester: 2)
        let s3 = Subject(id: "CSE301", name: "Algorithms", credits: 3, semester: 3)
        
       
        let t1 = Teacher(id: "T001", name: "Nguyen Van A", subjects: [s1, s2], department: "IT")
        let t2 = Teacher(id: "T002", name: "Tran Thi B", subjects: [s3], department: "CS")
        
                log += t1.displayInfo()
        log += t2.displayInfo()
        
        log += "*** Students ***\n"
        let st1 = Student(id: "SV001", name: "Le Minh", year: 1, gpa: 3.2)
        let st2 = Student(id: "SV002", name: "Pham Hoa", year: 2, gpa: 3.6)
        let st3 = Student(id: "SV003", name: "Tran An", year: 3, gpa: 3.8)
        
        
        log += st1.displayInfo() + "\n"
        log += st2.displayInfo() + "\n"
        log += st3.displayInfo() + "\n"
        
        log += "*** Student Marks ***\n"
        let m1 = StudentSubject(studentId: "SV001", subjectId: "CSE101", year: 2026, mark: 8.5)
        let m2 = StudentSubject(studentId: "SV001", subjectId: "CSE201", year: 2026, mark: 7.0)
        let m3 = StudentSubject(studentId: "SV002", subjectId: "CSE301", year: 2026, mark: 9.0)
        
        log += m1.displayInfo() + "\n"
        log += m2.displayInfo() + "\n"
        log += m3.displayInfo() + "\n"
        
        outputText = log
    }
}
