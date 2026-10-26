//
//  Same Delivery.swift
//  Practice 2: Delivery Service Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class SameDayDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 60000.0
    }
    
    override func getEstimatedDeliveryTime() -> String {
        return "Same day"
    }
    
    override func displayOrderInfo() -> String {
        let baseInfo = super.displayOrderInfo()
        return "\(baseInfo)\nService: Same-Day Delivery (ETA: \(getEstimatedDeliveryTime())) | Fee: \(calculateDeliveryFee()) VND"
    }
}
