//
//  Electricity Bill.swift
//  Utility Bill Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class ElectricityBill: UtilityBill {
    private var consumedKWh: Double
    
    init(billID: String, customerName: String, customerAddress: String, billingMonth: Int, billingYear: Int, consumedKWh: Double) {
        self.consumedKWh = consumedKWh
        
        super.init(billID: billID, customerName: customerName, customerAddress: customerAddress, billingMonth: billingMonth, billingYear: billingYear, serviceCategory: .electricity)
    }
    
    func getConsumedKWh() -> Double { return consumedKWh }
    func setConsumedKWh(_ kwh: Double) { self.consumedKWh = kwh }
    
    override func calculateCharge() -> Double {
        return consumedKWh * 2500.0
    }
}
