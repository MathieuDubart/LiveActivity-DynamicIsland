//
//  PizzaDeliveryAttributes.swift
//  DynamicIslandDemoProject
//
//  Created by Mathieu Dubart on 06/08/2024.
//

import SwiftUI
import ActivityKit

struct PizzaDeliveryAttributes: ActivityAttributes {
    public typealias PizzaDeliveryStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var driverName: String
        var arrivalTime: String
        var phoneNumber: String
        var restaurantName: String
        var customerAddress: String
        var remainingDistance: String
    }
    
    var numberOfPizzas: Int
    var totalAmount: String
}
