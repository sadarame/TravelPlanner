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
    @Binding var canSwiped: Bool
    
    // MARK: 初期処理
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        
        self._selectedTab = selectedTab
        self._canSwiped = canSwipe
    
    }
    
    func onloadView(){
       
    }
    
    // MARK: - GPTに送る処理
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

    // MARK: - GPTへリクエスト
    func requestGpt() {
        //スワイプできないように制御
        canSwiped = false
        
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
