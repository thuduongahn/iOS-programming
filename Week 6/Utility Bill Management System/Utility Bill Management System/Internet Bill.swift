//
//  Internet Bill.swift
//  Utility Bill Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class InternetBill: UtilityBill {
    init (billID: String, customerName: String, customerAddress: String, billingMonth: Int, billingYear: Int) {
        super.init(billID: billID, customerName: customerName, customerAddress: customerAddress, billingMonth: billingMonth, billingYear: billingYear, serviceCategory: .internet)
    }
    
    override func calculateCharge() -> Double {
        return 200000.0
    }
}
