//
//  UserDefaultManager.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation

func saveDocumentID(_ id: String) {
    UserDefaults.standard.set(id, forKey: "DocumentID")
}

func loadDocumentID() -> String? {
    return UserDefaults.standard.string(forKey: "DocumentID")
}

func saveGptText(_ id: String) {
    UserDefaults.standard.set(id, forKey: "GptText")
}

func loadGptText() -> String? {
    return UserDefaults.standard.string(forKey: "GptText")
}



func saveTravelPlanHist(_ model: TravelPlanModel) {
    do {
        var tmpList = loadTravelPlanHistList() ?? []  // 読み込み
        tmpList.append(model)  // 新しいデータを追加

        let data = try JSONEncoder().encode(tmpList)
        UserDefaults.standard.set(data, forKey: "TravelPlanHist")
    } catch {
        print("Failed to save TravelPlanModel: \(error)")
    }
}


func loadTravelPlanHistList() -> [TravelPlanModel]? {
    if let data = UserDefaults.standard.data(forKey: "TravelPlanHist") {
        do {
            let model = try JSONDecoder().decode([TravelPlanModel].self, from: data)
            return model
        } catch {
            print("Failed to load NotificateModel: \(error)")
        }
    }
    return nil
}


func saveHistoryText(_ txt: String) {
    UserDefaults.standard.set(txt, forKey: "HistoryText")
}

func loadHistoryText() -> String? {
    return UserDefaults.standard.string(forKey: "HistoryText")
}


