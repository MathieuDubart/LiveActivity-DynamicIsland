//
//  PizzaDeliveryActivity.swift
//  PizzaDeliveryActivity
//
//  Created by Mathieu Dubart on 06/08/2024.
//

import WidgetKit
import SwiftUI


struct PizzaDeliveryActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PizzaDeliveryAttributes.self) { context in
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.yellow)
                    
                    Spacer()
                        .frame(width: 16)
                    
                    Text(timerInterval: Date()...Date().addingTimeInterval(15*60), countsDown: true)
                        .font(.system(size: 16))
                        .bold()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Driver")
                            .font(.system(size: 8))
                        Text(context.state.driverName)
                            .font(.system(size: 14))
                            .bold()
                        Text("(4.4⭐️)")
                            .font(.system(size: 10))
                    }
                    
                }
                
                
                HStack {
                    Image(systemName: "figure.outdoor.cycle")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.yellow)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Your food is on delivery")
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("From")
                            .font(.system(size: 8))
                        Text(context.state.restaurantName)
                            .font(.system(size: 14))
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("To")
                            .font(.system(size: 8))
                        Text(context.state.customerAddress)
                            .lineLimit(1)
                            .font(.system(size: 14))
                            .bold()
                    }
                }
                HStack {
                    ProgressView(value: CGFloat((context.state.remainingDistance as NSString).floatValue), total: 100)
                        .tint(.yellow)
                        .background(.white)
                }
            }
            .padding(.all, 12)
        }
        dynamicIsland: { context in
            
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    HStack{
                        HStack {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.yellow)
                            
                            Spacer()
                                .frame(width: 12)
                            
                            Text(timerInterval: Date()...Date().addingTimeInterval(15*60), countsDown: true)
                                .font(.system(size: 16))
                                .bold()
                        }
                        .frame(width: 120)
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Image(systemName: "figure.outdoor.cycle")
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.yellow)
                                
                                VStack(spacing: 0) {
                                    HStack {
                                        Text("Your food is on delivery")
                                            .font(.system(size: 20))
                                            .bold()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("From")
                                    .font(.system(size: 8))
                                Text(context.state.restaurantName)
                                    .font(.system(size: 14))
                                    .bold()
                            }
                            
                            Spacer()
                                .frame(width: 12)
                            
                            VStack(alignment: .leading) {
                                Text("To")
                                    .font(.system(size: 8))
                                Text(context.state.customerAddress)
                                    .lineLimit(1)
                                    .font(.system(size: 14))
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        Button {} label: {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                    .foregroundStyle(.white)
                                
                                Text("Call")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonBorderShape(.capsule)
                    }
                    .padding(.horizontal, 12)
                }
                
            } compactLeading: { //Compact leading dynamic island
                HStack {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundStyle(Color.white)
                    
                    Text("En route")
                }
                .padding(.leading, 12)
            } compactTrailing: { //Compact trailing dynamix island
                VStack(alignment: .trailing) {
                    Text(timerInterval: Date()...Date().addingTimeInterval(15*60), countsDown: true)
                        .monospacedDigit()
                        .frame(width: 42)
                }
                .padding(.trailing, 10)
            } minimal: { //Minimal view dynamic island
                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.white)
            }
        }
    }
}
