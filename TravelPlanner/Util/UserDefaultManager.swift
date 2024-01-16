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

func saveTravelPlanHistList(_ list: [TravelPlanModel]) {
    do {
        let data = try JSONEncoder().encode(list)
        UserDefaults.standard.set(data, forKey: "TravelPlanHist")
    } catch {
        print("Failed to save TravelPlanHistList: \(error)")
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


func saveMstData(_ model: MstModel) {
    do {
        let data = try JSONEncoder().encode(model)
        UserDefaults.standard.set(data, forKey: "mstData")
        
    } catch {
        print("Failed to save garbage regist models: \(error)")
    }
}



func loadMstData() -> MstModel {
    if let data = UserDefaults.standard.data(forKey: "mstData") {
        do {
            let model = try JSONDecoder().decode(MstModel.self, from: data)
            return model
        } catch {
            print("Failed to load garbage regist models: \(error)")
        }
    }
    return MstModel()
}


func saveButtonPressModel(_ model: ButtonPressModel) {
    do {
        let data = try JSONEncoder().encode(model)
        UserDefaults.standard.set(data, forKey: "buttonPressModel")
        
    } catch {
        print("Failed to save garbage regist models: \(error)")
    }
}

func loadButtonPressModel() -> ButtonPressModel {
    if let data = UserDefaults.standard.data(forKey: "buttonPressModel") {
        do {
            let model = try JSONDecoder().decode(ButtonPressModel.self, from: data)
            return model
        } catch {
            print("Failed to load garbage regist models: \(error)")
        }
    }
    return ButtonPressModel()
}


func saveBlockingUser(_ useridList: [String]) {
    UserDefaults.standard.set(useridList, forKey: "BlockingUser")
}

func loadBlockingUser() -> [String] {
    return UserDefaults.standard.stringArray(forKey: "BlockingUser") ?? [String]()
}

