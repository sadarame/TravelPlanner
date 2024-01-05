//
//  ResultPlanModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/16.
//

import Foundation

struct ScheduleModel: Codable {
    var travelplanName:String
    var travelplan: [DayPlanModel]
}

struct DayPlanModel: Codable,Hashable {
    var day: Int
    var beginTime: String
    var endTime:  String
    var title: String
    var description: String
    
    static func createSampleDayPlan() -> DayPlanModel {
            return DayPlanModel(day: 1, beginTime: "09:00", endTime: "12:00", title: "Sample Plan", description: "Sample Description")
    }
    
    func formattedBeginTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        // String型のbeginTimeをDate型に変換
        if let date = dateFormatter.date(from: beginTime) {
            // Date型を"HH:mm"形式の文字列に変換して返す
            return dateFormatter.string(from: date)
        } else {
            // 変換に失敗した場合は空文字を返す
            return ""
        }
    }
    
    func formattedEndTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        // String型のbeginTimeをDate型に変換
        guard let date = dateFormatter.date(from: endTime) else {
            return "" // 変換に失敗した場合はnilを返す
        }

        // Date型を"HH:mm"形式の文字列に変換
        return dateFormatter.string(from: date)
    }
}


extension ScheduleModel {
    static func loadModelData() -> ScheduleModel {
        // loadGptText() が String を返すと仮定
        guard let jsonString = loadGptText(),
              let jsonData = jsonString.data(using: .utf8) else {
            print("Error converting JSON string to data")
            return ScheduleModel(travelplanName: "", travelplan: [])  // デフォルト値を返すか、空の配列を持つモデルを返すなど、適切な初期値を返す
        }

        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ScheduleModel.self, from: jsonData)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return ScheduleModel(travelplanName: "", travelplan: [])  // デコードエラー時も適切な初期値を返す
        }
    }
    
    static func createFromJsonString(_ jsonString: String) -> ScheduleModel {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error converting JSON string to data")
            return ScheduleModel(travelplanName: "", travelplan: [])
        }

        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ScheduleModel.self, from: jsonData)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return ScheduleModel(travelplanName: "", travelplan: [])  
        }
    }
}
