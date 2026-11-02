import Foundation
import SwiftUI
import Combine

// Custom Error for handling invalid operations
enum LibraryError: LocalizedError {
    case alreadyBorrowed
    case notBorrowable
    case maxUsersReached
    
    var errorDescription: String? {
        switch self {
        case .alreadyBorrowed: return "Operation failed: This resource is currently borrowed."
        case .notBorrowable: return "Operation failed: This journal is for reference only."
        case .maxUsersReached: return "Operation failed: Maximum concurrent users reached."
        }
    }
}

// Base class representing a library resource
class LibraryResource: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let baseFee: Double
    
    // Encapsulation: State can only be read externally, modification must go through methods
    @Published fileprivate(set) var isAvailable: Bool
    
    init(title: String, baseFee: Double = 0.0, isAvailable: Bool = true) {
        self.title = title
        self.baseFee = baseFee
        self.isAvailable = isAvailable
    }
    
    // Polymorphism: Method can be overridden by subclasses
    func requestAccess() throws -> Double {
        guard isAvailable else {
            throw LibraryError.alreadyBorrowed
        }
        isAvailable = false
        return baseFee
    }
    
    func returnResource() {
        isAvailable = true
    }
}

// Subclass: Printed Book
class PrintedBook: LibraryResource {
    let author: String
    let isbn: String
    
    init(title: String, author: String, isbn: String, baseFee: Double) {
        self.author = author
        self.isbn = isbn
        super.init(title: title, baseFee: baseFee)
    }
}

// Subclass: Academic Journal
class AcademicJournal: LibraryResource {
    let volume: Int
    let issue: Int
    let canBorrow: Bool
    
    init(title: String, volume: Int, issue: Int, canBorrow: Bool) {
        self.volume = volume
        self.issue = issue
        self.canBorrow = canBorrow
        super.init(title: title, baseFee: 0.0)
    }
    
    // Override method to add journal-specific validation
    override func requestAccess() throws -> Double {
        guard canBorrow else {
            throw LibraryError.notBorrowable
        }
        return try super.requestAccess()
    }
}

// Subclass: Digital Material
class DigitalMaterial: LibraryResource {
    let platform: String
    let maxUsers: Int
    @Published fileprivate(set) var currentUsers: Int
    
    init(title: String, platform: String, maxUsers: Int, baseFee: Double) {
        self.platform = platform
        self.maxUsers = maxUsers
        self.currentUsers = 0
        super.init(title: title, baseFee: baseFee)
    }
    
    override func requestAccess() throws -> Double {
        guard currentUsers < maxUsers else {
            throw LibraryError.maxUsersReached
        }
        currentUsers += 1
        if currentUsers == maxUsers {
            isAvailable = false // No more access slots
        }
        return baseFee
    }
    
    override func returnResource() {
        if currentUsers > 0 {
            currentUsers -= 1
            isAvailable = true
        }
    }
}
