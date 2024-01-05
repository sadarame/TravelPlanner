//
//  SharedModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/13.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SharedModel: Identifiable, Codable {
    @DocumentID var id: String?
    var input_message: String
    var response_message: String
    var user_id: String
    var timestamp: Date
    
    func timeAgoSinceDate() -> String {
            let currentDate: Date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute, .hour, .day], from: timestamp, to: currentDate)
            
            if let day = components.day, day > 0 {
                return "\(day)日前"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour)時間前"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute)分前"
            } else {
                return "たった今"
            }
        }
    
    func getPlanTitle() -> String {
        let schedule = GlobalCalendarVM.shared.getScheduleModeFromJson(strJson: response_message)
        return schedule.travelplanName
    }

}
