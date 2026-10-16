import SwiftUI

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
    
    
    init() {
        self.id = ""
        self.name = ""
        self.subjects = []
        self.department = ""
    }
    
    init(id: String, name: String, subjects: [Subject], department: String) {
        self.id = id
        self.name = name
        self.subjects = subjects
        self.department = department
    }
    
    
    func getId() -> String { return id }
    func getName() -> String { return name }
    func getSubjects() -> [Subject] { return subjects }
    func getDepartment() -> String { return department }
    
    func setId(_ newId: String) { id = newId }
    func setName(_ newName: String) { name = newName }
    func setDepartment(_ newDepartment: String) { department = newDepartment }
    
    func addSubject(_ subject: Subject) {
        subjects.append(subject)
    }
    
    func removeSubject(id: String) {
        
        subjects.removeAll { $0.getId() == id }
    }
    
    func displayInfo() -> String {
        var info = "Teacher Information\n"
        info += "-------------------\n"
        info += "ID: \(id)\n"
        info += "Name: \(name)\n"
        info += "Department: \(department)\n"
        info += "Subjects:\n"
        
        for subject in subjects {
            info += "- \(subject.displayInfo())\n"
        }
        
        return info
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
        var log = ""
        
        let s1 = Subject(id: "CSE101", name: "iOS Programming", credits: 3, semester: 1)
        let s2 = Subject(id: "CSE201", name: "Data Structures", credits: 4, semester: 2)
        let s3 = Subject(id: "CSE301", name: "Algorithms", credits: 3, semester: 3)
        
        let t1 = Teacher(id: "T001", name: "Nguyen Van A", subjects: [s1, s2], department: "Information Technology")
        
        t1.addSubject(s3)
        
        log = t1.displayInfo()
        
       
        outputText = log
    }
}
