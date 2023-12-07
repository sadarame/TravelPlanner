//
//  InputPlanVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation
import SwiftUI

class InputPlanVM: BaseVM {
    
    @Published var model:TravelPlanModel = TravelPlanModel()
    @Binding var selectedTab: Int
    @Binding var canSwipe: Bool
 
    
    // MARK: 初期処理
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        
        
        self._selectedTab = selectedTab
        self._canSwipe = canSwipe
        super.init()
        
        let t = loadHistoryText()
        if t != "" {
            self.model.text = t ?? ""
        }
        saveHistoryText("")
    }
    
    func onloadView(){
        //履歴画面から遷移した場合
        var t = loadHistoryText()
        if t != "" {
            model.text = t ?? ""
        }
        saveHistoryText("")
        
//        appState.selection = 2
        
       
    }
    
    // MARK: - GPTに送る処理
    func createTravelPlan(){
        //履歴を保存
        saveTravelPlanHist(model)
        //リクエスト送信
        requestGpt()
    }
    
    // MARK: - クリア
    func clearText(){
        model.text = ""
    }
    
    // MARK: - 通信成功時の処理
    func afterRequesSuccess(resModel:gptResponseModel) {
        DispatchQueue.main.async {
            // 応答値を保存
            saveDocumentID(resModel.documentId)
            self.model.documentID = resModel.documentId
            self.model.resText = resModel.responseMessage
            saveTravelPlanHist(self.model)
            //画面遷移
            saveGptText(resModel.responseMessage)
            self.canSwipe = true
            self.selectedTab = 2
            
        }
    }

    // MARK: - GPTへリクエスト
    func requestGpt() {
        //スワイプできないように制御
        canSwipe = false
        
        // リクエストデータ
        let requestData: [String: Any] = [
            "document_id": model.documentID,
            "user_message": model.text
        ]

        do {
            // JSONデータに変換
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)

            fetchDataFromAPI(url: Const.url_gptAPI, jsonData: jsonData) { (result: Result<gptResponseModel, Error>) in
                       
                       switch result {
                       case .success(let responseData):
                           //通信成功時の処理
                           self.afterRequesSuccess(resModel: responseData)
                           
                       case .failure(let error):
                           // エラー時の処理
                           self.showUserMessage(withMessage: Const.msg_error_API)
                           print("Error converting data to JSON: \(error)")
                          
                       }
                   }
               }catch {
                   self.showUserMessage(withMessage: Const.msg_error_common)
                   print("Error converting data to JSON: \(error)")
        }
    }
    
    
}
