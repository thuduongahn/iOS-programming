//
//  Water Bill.swift
//  Utility Bill Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class WaterBill: UtilityBill {
    private var consumedM3: Double
    
    init(billID: String, customerName: String, customerAddress: String, billingMonth: Int, billingYear: Int, consumedM3: Double) {
        self.consumedM3 = consumedM3
        super.init(billID: billID, customerName: customerName, customerAddress: customerAddress, billingMonth: billingMonth, billingYear: billingYear, serviceCategory: .water)
    }
    
    func getConsumedM3() -> Double { return consumedM3 }
    func setConsumedM3(_ m3: Double) { self.consumedM3 = m3 }
    
    override func calculateCharge() -> Double {
        return consumedM3 * 10000.0
    }
}
