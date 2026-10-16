import SwiftUI

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
        var log = "Subject Class Example\n"

        let s1 = Subject()
        let s2 = Subject(id: "P01", name: "iOS Programming")
        let s3 = Subject(id: "P02", name: "Data Structures", credits: 3, semester: 1)
        
        s1.setId("P03")
        s1.setName("Algorithms")
        s1.setCredits(4)
        s1.setSemester(2)
        
        log += s1.displayInfo() + "\n"
        log += s2.displayInfo() + "\n"
        log += s3.displayInfo() + "\n"
        
        outputText = log
    }
}
