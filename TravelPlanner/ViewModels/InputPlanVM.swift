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
    var buttonPressModel:ButtonPressModel = ButtonPressModel()
    
    @Binding var selectedTab: Int
    @Binding var canSwiped: Bool
    
    //リクエストを送った回数
    @AppStorage("lastUserMessageID") var lastUserMessageID = ""
    
    
    // MARK: 初期処理
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        
        self._selectedTab = selectedTab
        self._canSwiped = canSwipe
    }
    
    func onloadView(){
       
    }
    
    // MARK: - GPTに送る前段処理
    func createTravelPlan(txt:String){
        model.text = txt
        //履歴を保存
        saveTravelPlanHist(model)
        //リクエスト送信
        requestGpt()
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
            self.canSwiped = true
            self.selectedTab = 2
            
        }
    }
    
    //上限計算
    func isRequestLimit() {
        
        buttonPressModel = loadButtonPressModel()
        
       if Calendar.current.isDateInToday(buttonPressModel.lastPressDate) {
            // 制限回数内かつ同じ日にボタンが押された場合
            buttonPressModel.buttonPressCount += 1
        } else {
            // 制限回数内で、前回の押下が昨日以前の場合
            buttonPressModel.buttonPressCount = 1
        }
        //保存
        saveButtonPressModel(buttonPressModel)
    }

    // MARK: - GPTへリクエスト
    func requestGpt() {
        
        isRequestLimit()
        
        //一日の上限を超えてた場合
        if buttonPressModel.isOverMaxCount {
            GlobalViewModel.shared.setAlertMessage(message: Const.msg_error_limit)
            return
        }
        
        //スワイプできないように制御
        canSwiped = false
        
        //定型文と結合して送信
        let user_message = model.text
        
        // リクエストデータ
        let requestData: [String: Any] = [
            "document_id": model.documentID,
            "user_message": user_message,
            "travelDuration":model.travelDuration
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
