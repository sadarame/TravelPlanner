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

    // 引数なしのイニシャライザ
    init() {
        self.id = UUID()
        self.text = "旅行の計画立てて"
        self.resText  = ""
        self.date = Date()
        self.documentID = loadDocumentID() ?? ""
    }

    init(id: UUID = UUID(), text: String, resText: String, date: Date,documentID:String) {
        self.id = id
        self.text = text
        self.resText  = resText
        self.date = date
        self.documentID = documentID
    }
}
