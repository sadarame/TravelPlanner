//
//  ScheduleModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation

class ScheduleModel {
    var id: UUID
    var startTime: Date
    var endTime: Date
    var title: String
    var description: String

    init(id: UUID = UUID(), startTime: Date, endTime: Date, title: String, description: String) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
        self.description = description
    }
}

// サンプルのスケジュールデータ
let sampleSchedules: [ScheduleModel] = [
    ScheduleModel(startTime: Date(), endTime: Date().addingTimeInterval(3600), title: "ミーティング", description: "プロジェクトの進捗報告"),
    ScheduleModel(startTime: Date().addingTimeInterval(3600), endTime: Date().addingTimeInterval(7200), title: "ランチ", description: "同僚とランチ"),
    ScheduleModel(startTime: Date().addingTimeInterval(7200), endTime: Date().addingTimeInterval(10800), title: "ジョギング", description: "公園でジョギング"),
]
