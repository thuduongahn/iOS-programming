//
//  3 bills.swift
//  Utility Bill Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
enum ServiceCategory: String {
    case electricity = "Electricity"
    case water = "Water"
    case internet = "Internet"
}

class UtilityBill {
    private var billID: String
    private var customerName: String
    private var customerAdress: String
    private var billingMonth: Int
    private var billingYear: Int
    private var serviceCategory: ServiceCategory
    
    init(billID: String, customerName: String, customerAddress: String, billingMonth: Int, billingYear: Int, serviceCategory: ServiceCategory){
        self.billID = billID
        self.customerName = customerName
        self.customerAdress = customerAddress
        self.billingMonth = billingMonth
        self.billingYear = billingYear
        self.serviceCategory = serviceCategory
    }
    func getBillID() -> String {return billID}
    func getCustomerName () -> String {return customerName}
    func getCustomerAdress () -> String {return customerAdress}
    func getBillingMonth () -> Int {return billingMonth}
    func getBillingYear () -> Int {return billingYear}
    func ServiceCategory () -> ServiceCategory {return serviceCategory}
    
    func setCustomerName(_ newName: String) {self.customerName = newName}
    func setCustomerAdress(_ newAddress: String) {self.customerAdress = newAddress}
    func setBillingDate(month: Int, year: Int) {
        self.billingMonth = month
        self.billingYear = year
    }
    
    func calculateCharge() -> Double {
        return 0.0
    }
    func displayBillInfo () {
        print("-------------------------------------")
        print("Bill ID: \(billID) | Service: \(serviceCategory.rawValue)")
        print("Customer: \(customerName) | \(customerAdress)")
        print("Billling Period: \(billingYear)/\(billingMonth)")
        print("Total charge: \(calculateCharge()) VND")
        
        let eBill = ElectricityBill(billID: "E001", customerName: "Thu", customerAddress: "District 12", billingMonth: 10, billingYear: 2026, consumedKWh: 150)
        eBill.displayBillInfo()

        let wBill = WaterBill(billID: "W001", customerName: "Thu", customerAddress: "District 12", billingMonth: 10, billingYear: 2026, consumedM3: 25)
        wBill.displayBillInfo()

        let iBill = InternetBill(billID: "I001", customerName: "Thu", customerAddress: "District 12", billingMonth: 10, billingYear: 2026)
        iBill.displayBillInfo()

    }
}

