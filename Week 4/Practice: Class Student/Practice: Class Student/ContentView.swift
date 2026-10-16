import SwiftUI

class Student {
    private var id: String
    private var name: String
    private var age: Int
    private var gpa: Double

    init() {
        self.id = ""
        self.name = ""
        self.age = 0
        self.gpa = 0.0
    }
    
    init(id: String) {
        self.id = id
        self.name = ""
        self.age = 0
        self.gpa = 0.0
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.age = 0
        self.gpa = 0.0
    }
    
    init(id: String, name: String, age: Int, gpa: Double) {
        self.id = id
        self.name = name
        self.age = age
        self.gpa = gpa
    }
    
    func getId() -> String { return id }
    func getName() -> String { return name }
    func getAge() -> Int { return age }
    func getGPA() -> Double { return gpa }
    
    func setId(_ newId: String) { self.id = newId }
    func setName(_ newName: String) { self.name = newName }
    func setAge(_ newAge: Int) { self.age = newAge }
    func setGPA(_ newGPA: Double) { self.gpa = newGPA }
    
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name), Age: \(age), GPA: \(gpa)"
    }
    
    func isExcellent() -> Bool {
        return gpa >= 3.5
    }
    
    func updateGPA(_ newGPA: Double) {
        self.gpa = newGPA
    }
}

struct ContentView: View {

    @State private var outputText: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(outputText)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
        }
        .onAppear {
            runMainLogic()
        }
    }
    
    func runMainLogic() {
        var log = ""
        let s1 = Student()
        let s2 = Student(id: "SV001")
        let s3 = Student(id: "SV002", name: "Lan")
        let s4 = Student(id: "SV003", name: "Minh", age: 20, gpa: 3.8)
        
        s1.setId("SV004")
        s1.setName("An")
        s1.setAge(19)
        s1.setGPA(3.2)
        
        log += "--- Student Information ---\n"
        log += s1.displayInfo() + "\n"
        log += s2.displayInfo() + "\n"
        log += s3.displayInfo() + "\n"
        log += s4.displayInfo() + "\n\n"
        
        log += "Check excellent students:\n"
        log += "s1 is Excellent? \(s1.isExcellent() ? "No" : "No")\n"
        log += "s4 is Excellent? \(s4.isExcellent() ? "Yes" : "No")\n\n"
        
        log += "Update GPA for s1...\n"
        s1.updateGPA(3.6)
        log += s1.displayInfo()
        
      
        outputText = log
    }
}
