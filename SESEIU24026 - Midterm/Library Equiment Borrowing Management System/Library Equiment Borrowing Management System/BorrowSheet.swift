import SwiftUI

struct BorrowSheet: View {
    @ObservedObject var item: Equipment
    @Environment(\.presentationMode) var presentationMode
    
    @State private var borrower = ""
    @State private var returnDate = Date().addingTimeInterval(86400 * 7)
    @State private var isLoan = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Borrower Name", text: $borrower)
                DatePicker("Expected Return Date", selection: $returnDate, displayedComponents: .date)
                
                // Nút chọn trạng thái nợ (Loan)
                Toggle("Include Debt (Set status to 'Loan')", isOn: $isLoan)
                
                Button("Confirm Transaction") {
                    do {
                        // Gọi hàm mượn và truyền trạng thái isLoan
                        try item.borrow(by: borrower, expectedReturn: returnDate, isLoan: isLoan)
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        errorMessage = error.localizedDescription
                        showError = true
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
            .navigationTitle("Borrow Registration")
            .toolbar {
                Button("Cancel") { presentationMode.wrappedValue.dismiss() }
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage))
            }
        }
    }
}
