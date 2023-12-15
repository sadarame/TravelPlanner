//
//  TravelPlanModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation

class TravelPlanModel: Identifiable, Codable {
    var id: UUID
    var text: String
    var resText:String
    var date: Date
    var documentID:String
    var travelDuration:Int

    // 引数なしのイニシャライザ
    init() {
        self.id = UUID()
        self.text = ""
        self.resText  = ""
        self.date = Date()
        self.documentID = loadDocumentID() ?? ""
        self.travelDuration = 1
    }

    init(id: UUID = UUID(), text: String, resText: String, date: Date,documentID:String,travelDuration:Int) {
        self.id = id
        self.text = text
        self.resText  = resText
        self.date = date
        self.documentID = documentID
        self.travelDuration = travelDuration
    }
}
