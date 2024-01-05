//
//  TravelPlanModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation

class TravelPlanModel: Identifiable, Codable {
    var id: UUID
    var planTitle:String
    var text: String
    var resText:String
    var date: Date
    var documentID:String
    var travelDuration:Int

    // 引数なしのイニシャライザ
    init() {
        self.id = UUID()
        self.planTitle = ""
        self.text = ""
        self.resText  = ""
        self.date = Date()
        self.documentID = loadDocumentID() ?? ""
        self.travelDuration = 1
    }

    init(id: UUID = UUID(), planTitle:String,text: String, resText: String, date: Date,documentID:String,travelDuration:Int) {
        self.id = id
        self.planTitle = planTitle
        self.text = text
        self.resText  = resText
        self.date = date
        self.documentID = documentID
        self.travelDuration = travelDuration
    }
    
    func timeAgoSinceDate() -> String {
            let currentDate: Date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: currentDate)
            
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
    
    
}
