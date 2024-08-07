//
//  ContentView.swift
//  DynamicIslandDemoProject
//
//  Created by Mathieu Dubart on 06/08/2024.
//

import ActivityKit
import SwiftUI
import UserNotifications

struct Pizza: Hashable {
    let price: Int
    var name: String
    var quantity: Int = 0
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                do {
                    deleteAllActivities()
                    
                    let id = try LiveActivityManager.startActivity(driverName: "Edward", arrivalTime: "15min", phoneNumber: "0123456789", restaurantName: "McDonald's", customerAddress: "12 rue du fleuve", remainingDistance: "34.6")
                    
                    UserDefaultsManager.saveNewActivity(id: id, driverName: "Edward", arrivalTime: "15min", phoneNumber: "0123456789", restaurantName: "McDonald's", customerAddress: "12 rue du fleuve", remainingDistance: "34.6")
                } catch {
                    print("error starting new activity from app: \(error.localizedDescription)")
                }
            } label: {
                Text("Place Order")
            }
            
            Spacer()
                .frame(height: 60)
            
            Button(role:.destructive) {
                deleteAllActivities()
            } label: {
                Text("Cancel Order")
            }
        }
        .padding()
        .onAppear {
            requestNotificationAuthorization()
        }
    }
    
    private func deleteAllActivities() {
        for item in UserDefaultsManager.fetchActivities() {
            if let activity = Activity<PizzaDeliveryAttributes>.activities.first(where: { $0.content.state.phoneNumber == item.phoneNumber }) {
                Task {
                    await LiveActivityManager.endActivity(id: activity.id)
                }
            }
        }
    }

    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Failed to request authorization: \(error.localizedDescription)")
            }
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Authorization denied")
            }
        }
    }
}

#Preview {
    ContentView()
}
