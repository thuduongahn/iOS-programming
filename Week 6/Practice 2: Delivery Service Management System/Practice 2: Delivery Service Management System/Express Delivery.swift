//
//  Express Delivery.swift
//  Practice 2: Delivery Service Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class ExpressDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 40000.0
    }
    
    override func getEstimatedDeliveryTime() -> String {
        return "1 to 2 days"
    }
    
    override func displayOrderInfo() -> String {
        let baseInfo = super.displayOrderInfo()
        return "\(baseInfo)\nService: Express Delivery (ETA: \(getEstimatedDeliveryTime())) | Fee: \(calculateDeliveryFee()) VND"
    }
}
    

