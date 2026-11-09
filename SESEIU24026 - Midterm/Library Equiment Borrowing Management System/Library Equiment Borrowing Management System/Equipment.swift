import Foundation

class Equipment: Identifiable, ObservableObject {
    let id: String
    let purchaseYear: Int
    
    @Published private(set) var name: String
    @Published private(set) var manufacturer: String
    @Published private(set) var status: EquipmentStatus = .available
    
    @Published private(set) var borrowerName: String?
    @Published private(set) var borrowDate: Date?
    @Published private(set) var expectedReturnDate: Date?
    
    init(id: String, name: String, manufacturer: String, purchaseYear: Int) {
        self.id = id
        self.name = name
        self.manufacturer = manufacturer
        self.purchaseYear = purchaseYear
    }
    
    func updateCommonInfo(name: String, manufacturer: String) throws {
        guard !name.isEmpty, !manufacturer.isEmpty else { throw LibraryError.emptyFields }
        self.name = name
        self.manufacturer = manufacturer
    }
    
    func borrow(by borrower: String, expectedReturn: Date, isLoan: Bool) throws {
        guard status == .available else { throw LibraryError.alreadyBorrowed }
        guard !borrower.isEmpty else { throw LibraryError.emptyFields }
        
        self.status = isLoan ? .loan : .borrowed
        self.borrowerName = borrower
        self.borrowDate = Date()
        self.expectedReturnDate = expectedReturn
    }
    
    func returnEquipment() throws {
        guard status != .available else { throw LibraryError.notBorrowed }
        
        self.status = .available
        self.borrowerName = nil
        self.borrowDate = nil
        self.expectedReturnDate = nil
    }
}
