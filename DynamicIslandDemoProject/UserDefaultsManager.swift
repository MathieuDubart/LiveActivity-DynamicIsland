//
//  UserDefaultsManager.swift
//  DynamicIslandDemoProject
//
//  Created by Mathieu Dubart on 06/08/2024.
//

import Foundation
import ActivityKit

struct UserDefaultsManager {
    static func saveNewActivity(
        id: String,
        driverName: String,
        arrivalTime: String,
        phoneNumber: String,
        restaurantName: String,
        customerAddress: String,
        remainingDistance: String
    ) {
        let activity = [
            "id": id,
            "driverName": driverName,
            "arrivalTime": arrivalTime,
            "phoneNumber": phoneNumber,
            "restaurantName": restaurantName,
            "customerAddress": customerAddress,
            "remainingDistance": remainingDistance
        ] as [String : Any]
        
        if var activities: [[String: Any]] = UserDefaults.standard.object(forKey: "live_activities") as? [[String : Any]] {
            activities.append(activity)
            UserDefaults.standard.set(activities, forKey: "live_activities")
        } else {
            UserDefaults.standard.set([activity], forKey: "live_activities")
        }
    }
    
    static func fetchActivities() -> [PizzaDeliveryAttributes.PizzaDeliveryStatus] {
        guard let activities: [[String: String]] = UserDefaults.standard.object(forKey: "live_activities") as? [[String : String]] else { return [] }
        
        return activities.compactMap ({
            PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: $0["driverName"]!, arrivalTime: $0["arrivalTime"]!, phoneNumber: $0["phoneNumber"]!, restaurantName: $0["restaurantName"]!, customerAddress: $0["customerAddress"]!, remainingDistance: $0["remainingDistance"] ?? "8.2")
        })
    }
}
