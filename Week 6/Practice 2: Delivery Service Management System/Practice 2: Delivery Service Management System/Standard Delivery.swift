//
//  Standard Delivery.swift
//  Practice 2: Delivery Service Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class StandardDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 20000.0
    }
    
    override func getEstimatedDeliveryTime() -> String {
        return "3 to 5 days"
    }
    
    override func displayOrderInfo() -> String {
        let baseInfo = super.displayOrderInfo()
        return "\(baseInfo)\nService: Standard Delivery (ETA: \(getEstimatedDeliveryTime())) | Fee: \(calculateDeliveryFee()) VND"
    }
}
