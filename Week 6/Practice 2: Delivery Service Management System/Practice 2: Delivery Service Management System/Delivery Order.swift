//
//  Delivery Order.swift
//  Practice 2: Delivery Service Management System
//
//  Created by ahn on 26/10/26.
//

import Foundation
class DeliveryOrder {
    private var orderID: String
    private var customerName: String
    private var deliveryAddress: String
    private var orderValue: Double
    
    init(orderID: String, customerName: String, deliveryAddress: String, orderValue: Double) {
        self.orderID = orderID
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.orderValue = orderValue
    }
    
    func getOrderID() -> String { return orderID }
    func getCustomerName() -> String { return customerName }
    func getDeliveryAddress() -> String { return deliveryAddress }
    func getOrderValue() -> Double { return orderValue }
    
    func setOrderID(_ id: String) { self.orderID = id }
    func setCustomerName(_ name: String) { self.customerName = name }
    func setDeliveryAddress(_ address: String) { self.deliveryAddress = address }
    func setOrderValue(_ value: Double) { self.orderValue = value }
    
    func calculateDeliveryFee() -> Double {
        return 0.0
    }
    
    func getEstimatedDeliveryTime() -> String {
        return "Unknown"
    }
    
    func displayOrderInfo() -> String {
        return "Order ID: \(orderID) | Customer: \(customerName) | Value: \(orderValue) VND\nAddress: \(deliveryAddress)"
    }
}
