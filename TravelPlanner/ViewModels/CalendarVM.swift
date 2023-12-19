//
//  CalendarVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/16.
//

import Foundation
import SwiftUI

final class CalendarVM: BaseVM {
    
   static let shared: CalendarVM = .init()
    
    //カレンダー用のモデル
    @Published var schedule:ScheduleModel = ScheduleModel.loadModelData()
    //カレンダー用の期間
    @AppStorage("durlation") var durlation: Int = 1
    
    
    //セルの高さ
    let height_cell:CGFloat = 100
    //ボタンの高さの割合（セルの高さにかけて使う）
    let height_cell_button:CGFloat = 0.95
    

    //受け取った期間の予定を返却する
    func getPlansForDayOne(days:Int)-> [DayPlanModel] {
        return schedule.travelplan.filter { $0.day == days }
    }
    
    //ボタンの高さを計算する
    func calcButtonHeight(plan:DayPlanModel) -> CGFloat {
        if let durationInHours = calculateDurationInHours(plan: plan) {
             return CGFloat(durationInHours) * height_cell * height_cell_button
         }
         return 0.0
    }
    
    // 予定の時間差を計算する
    func calculateDurationInHours(plan: DayPlanModel) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if let beginDate = dateFormatter.date(from: plan.beginTime),
           let endDate = dateFormatter.date(from: plan.endTime) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour], from: beginDate, to: endDate)
            if let hours = components.hour {
                return hours
            }
        }

        return nil
    }
    
    // MARK: - Jsonから予定モデルへ変換
    func fetchScheduleFromJson(strJson:String){
        self.schedule = ScheduleModel.createFromJsonString(strJson)
    }
    
    
    
    func dayPlansForHour(_ hour: Int) -> [DayPlanModel] {
           let predicate = NSPredicate(format: "beginTimeHour == %d", hour)
           return schedule.travelplan.filter { predicate.evaluate(with: $0) }
       }
    
}

extension DayPlanModel {
    var beginTimeHour: Int {
        if let hour = Int(beginTime.components(separatedBy: ":")[safe: 0] ?? "") {
            return hour
        }
        return 0
    }
}

// Extension to safely access array elements
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
