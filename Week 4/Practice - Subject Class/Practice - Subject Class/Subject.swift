import Foundation

class Subject {
    private var id: String
    private var name: String
    private var credits: Int
    private var semester: Int
    
    init() {
        self.id = ""
        self.name = ""
        self.credits = 0
        self.semester = 0
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.credits = 0
        self.semester = 0
    }
    
    init(id: String, name: String, credits: Int, semester: Int) {
        self.id = id
        self.name = name
        self.credits = credits
        self.semester = semester
    }
    
    func getId() -> String { return id }
    func getName() -> String { return name }
    func getCredits() -> Int { return credits }
    func getSemester() -> Int { return semester }
    
    func setId(_ newId: String) { id = newId }
    func setName(_ newName: String) { name = newName }
    func setCredits(_ newCredits: Int) { credits = newCredits }
    func setSemester(_ newSemester: Int) { semester = newSemester }
    
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name), Credits: \(credits), Semester: \(semester)"
    }
}
