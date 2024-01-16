//
//  HistoryVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class HistoryVM: BaseVM {
    
    @Binding var selectedTab: Int
    @Published var planHistList:[TravelPlanModel]
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.planHistList = loadTravelPlanHistList() ?? []
    }
    
    func onloadView() {
        planHistList = loadTravelPlanHistList() ?? []
    }
    
    func deletePlan(at index: Int) {
        //Sharedのデータを削除
        deleteShared(id: planHistList[index].sharedID)
        // 渡されたインデックスセットに基づいてアイテムを削除
        planHistList.remove(at: index)
        // 削除後のリストを保存または必要な処理を実行
        saveTravelPlanHistList(planHistList)
    }
    
    //
    func deleteShared(id: String) {
        let db = Firestore.firestore()
        let sharedCollection = db.collection("Shared")

        // ドキュメントを削除
        sharedCollection.document(id).delete { error in
            if let error = error {
                print("ドキュメントの削除に失敗しました: \(error.localizedDescription)")
            } else {
                print("ドキュメントが削除されました")
            }
        }
    }

}
