//
//  Library_Resource_ManagementApp.swift
//  Library Resource Management
//
//  Created by MAY 07 on 2/11/26.
//

import SwiftUI
import Combine 

class LibraryViewModel: ObservableObject {
    @Published var resources: [LibraryResource] = []
    
    init() {
        // Initialize mock data for testing
        resources = [
            PrintedBook(title: "Astrophysics for People in a Hurry", author: "Neil deGrasse Tyson", isbn: "978-0393609394", baseFee: 5.0),
            PrintedBook(title: "Fundamentals of Astrodynamics", author: "Roger R. Bate", isbn: "978-0486600611", baseFee: 3.5),
            AcademicJournal(title: "Nature Astronomy", volume: 10, issue: 2, canBorrow: false),
            DigitalMaterial(title: "OpenRocket Flight Simulation Guide", platform: "Library Portal", maxUsers: 1, baseFee: 0.0)
        ]
    }
}
