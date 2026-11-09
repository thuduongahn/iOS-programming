import Foundation

enum LibraryError: Error, LocalizedError {
    case alreadyBorrowed
    case notBorrowed
    case duplicateID
    case emptyFields
    
    var errorDescription: String? {
        switch self {
        case .alreadyBorrowed: return "Action denied: This equipment is already borrowed."
        case .notBorrowed: return "Action denied: This equipment is not currently borrowed."
        case .duplicateID: return "Action denied: The Equipment ID already exists."
        case .emptyFields: return "Please fill in all required fields."
        }
    }
}

enum EquipmentStatus: String {
    case available = "Available"
    case borrowed = "Borrowed"
    case loan = "Loan"
}

