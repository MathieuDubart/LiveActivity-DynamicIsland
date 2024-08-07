//
//  LiveActivityManager.swift
//  DynamicIslandDemoProject
//
//  Created by Mathieu Dubart on 06/08/2024.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    
    @discardableResult
    static func startActivity(
     driverName: String,
     arrivalTime: String,
     phoneNumber: String,
     restaurantName: String,
     customerAddress: String,
     remainingDistance: String
    ) throws -> String {
        let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 2, totalAmount: "$33")
        let initialContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: driverName, arrivalTime: arrivalTime, phoneNumber: phoneNumber, restaurantName: restaurantName, customerAddress: customerAddress, remainingDistance: remainingDistance)
        
        do {
            let deliveryActivity = try? Activity<PizzaDeliveryAttributes>.request(attributes: pizzaDeliveryAttributes, content: ActivityContent(state: initialContentState, staleDate: Date().addingTimeInterval(30 * 60)), pushType: nil)
            
            guard let id = deliveryActivity?.id else {
                throw LiveActvitiyTypeError.FailedToGetID
            }
            
            return id
        } catch {
            print("Error requesting pizza delivery Live Activity : \(error.localizedDescription)")
            throw error
        }
    }
    
    static func listAllActivities() -> [[String: String]] {
        let sortedActivities = Activity<PizzaDeliveryAttributes>.activities.sorted{ $0.id > $1.id }
        
        return sortedActivities.map {
            [
                "id": $0.id,
                "arrivalTime": $0.content.state.arrivalTime,
                "phoneNumber": $0.content.state.phoneNumber,
                "restaurantName": $0.content.state.restaurantName,
                "customerAdress": $0.content.state.customerAddress,
                "remainingDistance": $0.content.state.remainingDistance
            ]
        }
    }
    
    static func endAllActivities() async {
        let activities = listAllActivities()
        
        for activity in Activity<PizzaDeliveryAttributes>.activities {
            await activity.end(dismissalPolicy: .immediate)
        }
    }
    
    static func endActivity(id: String) async {
        await Activity<PizzaDeliveryAttributes>.activities.first(where: { $0.id == id })?.end(dismissalPolicy: .immediate)
    }
    
    static func updateActivity(_ id: String,
                               driverName: String,
                               arrivalTime: String,
                               phoneNumber: String,
                               restaurantName: String,
                               customerAddress: String,
                               remainingDistance: String
    ) async {
        let updatedContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: driverName, arrivalTime: arrivalTime, phoneNumber: phoneNumber, restaurantName: restaurantName, customerAddress: customerAddress, remainingDistance: remainingDistance)
        
        let activity = Activity<PizzaDeliveryAttributes>.activities.first(where: { $0.id == id })
        await activity?.update(using: updatedContentState)
    }
}

enum LiveActvitiyTypeError: Error {
    case FailedToGetID
}
