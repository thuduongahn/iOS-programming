//
//  ContentView.swift
//  PracticeTest1
//
//  Created by ahn on 19/10/26.

import SwiftUI
import Combine

class Student: Identifiable {
    var id: String
    var name: String
    var age: Int
    
    init(id:String, name: String, age: Int){
        self.id = id
        self.name = name
        self.age = age
    }
    func getId() -> String {return id}
    func setId(_ newId: String) {self.id = newId}
    
    func getName() -> String {return name}
    func setName(_ newName: String) {self.name = newName}
    
    func getAge() -> Int {return age}
    func setAge(_ newAge: Int){
        if newAge > 0 {self.age = newAge}
    }
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name), Age: \(age)"
    }
}

class Subject: Identifiable {
    var id: String
    var name: String
    var credits: Int
    
    init(id: String, name: String, credits: Int) {
        self.id = id
        self.name = name
        self.credits = credits
    }
    func getId() -> String {return id}
    func setId(_ newId: String) {self.id = newId}
    
    func getName() -> String {return name}
    func setName(_ newName: String) {self.name = newName}
    
    func getCredits() -> Int {return credits}
    func setCredits(_ newCredits: Int){
        if newCredits > 0 {self.credits = newCredits}
    }
    func displaySubjectInfo() -> String {
        return "\(name) (\(id) - \(credits) credits)"
    }
}

class StudentRecord: Identifiable {
    let recordId = UUID()
    var student: Student
    var subject: Subject
    private var _mark: Double = 0.0
    var academicYear: String
    
    var mark: Double {
        get { return _mark }
        set { _mark = min(max(newValue, 0.0), 10.0) }
    }
    
    init(student: Student, subject: Subject, mark: Double, academicYear: String = "2025-2026") {
        self.student = student
        self.subject = subject
        self.academicYear = academicYear
        self.mark = mark
    }
        func getMark() -> Double { return mark }
    
    @discardableResult
        func setMark(_ newMark: Double) -> Bool {
            guard newMark >= 0.0 && newMark <= 10.0 else {
                return false
            }
            self._mark = newMark
            return true
        }
        
    func isPassed() -> Bool {
            return mark >= 5.0
        }
    }

class CourseRegistrationViewModel: ObservableObject {
    @Published var students: [Student] = []
    @Published var subjects: [Subject] = []
    @Published var records: [StudentRecord] = []
    @Published var errorMessage: String? = nil
    
    init() {
        loadSampleData()
    }
    
    func loadSampleData() {
        let s1 = Student(id: "SV01", name: "Duong Ngoc Anh Thu", age: 20)
        let s2 = Student(id: "SV02", name: "Le Vo Anh Thu", age: 21)
        let s3 = Student(id: "SV03", name: "Tran Phuong Ha", age: 19)
        let s4 = Student(id: "SV04", name: "Mai Quoc Minh Tam", age: 22)
        let s5 = Student(id: "SV05", name: "Nguyen Van A", age: 22)
        students = [s1, s2, s3, s4, s5]
        
        let sub1 = Subject(id: "IOS101", name: "iOS Programming", credits: 4)
        let sub2 = Subject(id: "DBS201", name: "Database Management", credits: 3)
        let sub3 = Subject(id: "PHA102", name: "Physics 3", credits: 3)
        let sub4 = Subject(id: "SCI301", name: "Space Communication", credits: 2)
        subjects = [sub1, sub2, sub3, sub4]
        
        _ = registerSubject(student: s1, subject: sub1, mark: 9.0, year: "2025-2026")
        _ = registerSubject(student: s1, subject: sub2, mark: 8.5, year: "2025-2026")
        
        _ = registerSubject(student: s2, subject: sub1, mark: 9.5, year: "2025-2026")
        _ = registerSubject(student: s2, subject: sub3, mark: 7.0, year: "2025-2026")
        
        _ = registerSubject(student: s3, subject: sub2, mark: 9.5, year: "2025-2026")
        _ = registerSubject(student: s3, subject: sub4, mark: 9.0, year: "2025-2026")
        
        _ = registerSubject(student: s4, subject: sub3, mark: 8.0, year: "2025-2026")
        _ = registerSubject(student: s4, subject: sub4, mark: 7.5, year: "2025-2026")
        
        _ = registerSubject(student: s5, subject: sub1, mark: 6.0, year: "2025-2026")
        _ = registerSubject(student: s5, subject: sub4, mark: 4.5, year: "2025-2026")
    }
    

    func registerSubject(student: Student, subject: Subject, mark: Double, year: String = "2025-2026") -> Bool {
        guard mark >= 0.0 && mark <= 10.0 else {
            errorMessage = "The range of mark from 0 to 10."
            return false
        }
        
        let isDuplicate = records.contains { record in
            record.student.id == student.id &&
            record.subject.id == subject.id &&
            record.academicYear == year
        }
        
        if isDuplicate {
            errorMessage = "Student \(student.name) registed \(subject.name) in \(year)!"
            return false
        }
        
        let newRecord = StudentRecord(student: student, subject: subject, mark: mark, academicYear: year)
        records.append(newRecord)
        errorMessage = nil
        return true
    }
    
    func getRecords(for student: Student) -> [StudentRecord] {
        return records.filter { $0.student.id == student.id }
    }
    
    func calculateWeightedAverage(for student: Student) -> Double {
        let studentRecords = getRecords(for: student)
        guard !studentRecords.isEmpty else { return 0.0 }
        
        var totalWeightedMarks = 0.0
        var totalCredits = 0
        
        for record in studentRecords {
            totalWeightedMarks += record.mark * Double(record.subject.credits)
            totalCredits += record.subject.credits
        }
        
        return totalCredits > 0 ? (totalWeightedMarks / Double(totalCredits)) : 0.0
    }
    
    func getAcademicRanking(for student: Student) -> String {
        let avg = calculateWeightedAverage(for: student)
        if avg >= 8.5 {
            return "Excellent"
        } else if avg >= 7.0 {
            return "Good"
        } else if avg >= 5.0 {
            return "Average"
        } else {
            return "Fail"
        }
    }
    func updateMark(for record: StudentRecord, newMarkString: String) -> Bool {
        guard let newMark = Double(newMarkString), newMark >= 0.0, newMark <= 10.0 else {
            errorMessage = "Error: The score must be from 0 to 10!"
            return false
        }
        objectWillChange.send()
        record.setMark(newMark)
        errorMessage = nil
        return true
    }
}

struct ContentView: View {
    @StateObject private var viewModel = CourseRegistrationViewModel()
    @State private var selectedFilter: String = "All"
    @State private var editingRecord: StudentRecord? = nil
    @State private var newMarkInput: String = ""
    @State private var showErrorAlert: Bool = false
    
    let filterOptions = ["All", "Excellent", "Good", "Average", "Fail"]
    
    var filteredStudents: [Student] {
        if selectedFilter == "All" {
            return viewModel.students
        }
        return viewModel.students.filter { viewModel.getAcademicRanking(for: $0) == selectedFilter }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Lọc theo học lực", selection: $selectedFilter) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(filteredStudents) { student in
                        Section(header: StudentHeaderView(student: student, viewModel: viewModel)) {
                            let studentRecords = viewModel.getRecords(for: student)
                            
                            ForEach(studentRecords) { record in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(record.subject.displaySubjectInfo())
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text("Year: \(record.academicYear)")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text(String(format: "Score: %.1f", record.mark))
                                            .font(.subheadline)
                                            .bold()
                                        
                                        Text(record.isPassed() ? "Passed" : "Failed")
                                            .font(.caption)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(record.isPassed() ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                            .foregroundColor(record.isPassed() ? .green : .red)
                                            .cornerRadius(4)
                                    }
                                    
                                    Button(action: {
                                        editingRecord = record
                                        newMarkInput = String(format: "%.1f", record.mark)
                                    }) {
                                        Image(systemName: "pencil.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(.leading, 8)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Study Management")
  
            .sheet(item: $editingRecord) { record in
                VStack(spacing: 20) {
                    Text("Score update")
                        .font(.headline)
                    
                    Text("\(record.student.name) - \(record.subject.name)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextField("Input new score", text: $newMarkInput)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                    
                    HStack(spacing: 20) {
                        Button("Cancel") {
                            editingRecord = nil
                        }
                        .foregroundColor(.red)
                        
                        Button("Save changes") {
                            if viewModel.updateMark(for: record, newMarkString: newMarkInput) {
                                editingRecord = nil
                            } else {
                                showErrorAlert = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .presentationDetents([.height(250)])
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("Invalid score!"),
                        message: Text(viewModel.errorMessage ?? "The score must be from 0 to 10!"),
                        dismissButton: .default(Text("Close"))
                    )
                }
            }
        }
    }
}

struct StudentHeaderView: View {
    let student: Student
    @ObservedObject var viewModel: CourseRegistrationViewModel
    
    var body: some View {
        let avg = viewModel.calculateWeightedAverage(for: student)
        let rank = viewModel.getAcademicRanking(for: student)
        
        VStack(alignment: .leading, spacing: 4) {
            Text(student.displayInfo())
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                Text(String(format: "Average (Weighted GPA): %.2f", avg))
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Spacer()
                Text("Ranking: \(rank)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(rank == "Fail" ? .red : .green)
            }
        }
        .padding(.vertical, 4)
    }
}
#Preview {
    ContentView()
}
