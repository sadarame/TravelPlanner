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
    
    @AppStorage("isShowedReward") var isShowedReward: Bool = false
    
    //送信制限のためのモデル
    var buttonPressModel:ButtonPressModel = ButtonPressModel()
    
    //画面制御用のバインディング
    @Binding var selectedTab: Int
    @Binding var canSwiped: Bool
    
    //リクエストを送った回数
    @AppStorage("lastUserMessageID") var lastUserMessageID = ""
    @AppStorage("durlation") var durlation: Int = 1
    
    // MARK: 初期処理
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        
        self._selectedTab = selectedTab
        self._canSwiped = canSwipe
    }
    
    func onloadView(){
       
    }
    
    func formatText(_ text: String) -> String {
        var cleanedText = text.replacingOccurrences(of: "\\n", with: "\n")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")
        return cleanedText
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
            // ドキュメントIDを保存
            saveDocumentID(resModel.documentId)
            
            //リクエスト、レスポンスを履歴として保存
            self.model.documentID = resModel.documentId
            self.model.resText = resModel.responseMessage
            saveTravelPlanHist(self.model)
            
            //応答画面用に直近のでデータ保存（微妙だからあとで見直し）
            saveGptText(resModel.responseMessage)
            self.canSwiped = true
            
            //GPTからの応答をモデルに変換
            self.durlation = self.model.travelDuration
            CalendarVM.shared.fetchScheduleFromJson(strJson: resModel.responseMessage)
            
            //カレンダービューへ遷移
            GlobalViewModel.shared.selection = 2
            
        }
    }
    
    //上限計算
    func isRequestLimit() -> Bool {
        
        buttonPressModel = loadButtonPressModel()
        
       if Calendar.current.isDateInToday(buttonPressModel.lastPressDate) {
            // 制限回数内かつ同じ日にボタンが押された場合
            buttonPressModel.buttonPressCount += 1
        } else {
            // 制限回数内で、前回の押下が昨日以前の場合
            buttonPressModel.buttonPressCount = 1
        }
        
        if buttonPressModel.buttonPressCount > 5 {
            return true
            
        } else {
            saveButtonPressModel(buttonPressModel)
        }
        
        return false
    }

    
    // 今日何回ボタンが押されたかを返すメソッド
    func numberOfButtonPressesToday() -> Int {
        var buttonPressModel = loadButtonPressModel()
        
        // もし今日の日付と最後にボタンが押された日が同じであれば
        if Calendar.current.isDateInToday(buttonPressModel.lastPressDate) {
            return buttonPressModel.buttonPressCount
        } else {
            // 同じ日でない場合は、今日の日付を更新してボタンカウントをリセット
            buttonPressModel.lastPressDate = Date()
            buttonPressModel.buttonPressCount = 0 // ここを1から始めたい場合は1に変更してください
            saveButtonPressModel(buttonPressModel)
            return 0 // カウントが0であることを返す
        }
        //保存
        saveButtonPressModel(buttonPressModel)
    }
    
    // MARK: - GPTへリクエスト
    func requestGpt() {
        
        //リクエスト上限の場合
        if isRequestLimit() {
            if !isShowedReward {
                GlobalViewModel.shared.setAdAlertMessage()
                return
            //見てた場合
            } else {
                //エラーチェックは通すけど、みてない扱いにする
                isShowedReward = false
            }
            
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
