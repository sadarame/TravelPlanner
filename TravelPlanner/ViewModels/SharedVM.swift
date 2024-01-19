//
//  SharedVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/13.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class SharedVM: BaseVM {
    
    @Binding var selectedTab: Int
    @Published var data:[SharedModel] = []
    @Published var alertflg = false
    
    init(selectedTab: Binding<Int>) {
        
        self._selectedTab = selectedTab
        super.init()
        self.fetchShared()
    }
    
    func fetchShared() {
        let blockList = loadBlockingUser()

        let db = Firestore.firestore()
        let collectionRef = db.collection("Shared")

        // user_idフィールドを基準に降順でデータを取得するようにクエリを設定
        var query = collectionRef
            .order(by: "user_id", descending: true)
            .limit(to: Const.fetchlimit)

        // blockListが空でない場合はwhereFieldを使用
        if !blockList.isEmpty {
            query = query.whereField("user_id", notIn: blockList)
        }

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                // Firestoreから取得したデータをYourDataType型にデコード
                do {
                    self.data = try querySnapshot?.documents.compactMap { document in
                        try document.data(as: SharedModel.self)
                    } ?? []

                    // データを日付順にソート
                    self.data.sort(by: { $0.timestamp > $1.timestamp })
                   
                } catch let error {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }
    }

    func blockingUser(blockID:String) {
        //ブロックユーザを追加
        var blockingUsers = loadBlockingUser()
        blockingUsers.append(blockID)
        saveBlockingUser(blockingUsers)
        
        //通報完了のメッセージ
        GlobalViewModel.shared.setAlertMessage(message: Const.msg_notice_block)
    }
    
   
    func reportUser(sharedModel: SharedModel) {
        let db = Firestore.firestore()
        do {
            var data = try Firestore.Encoder().encode(sharedModel)
            // Firestoreのコレクションにデータを追加
            var ref: DocumentReference? = nil
            ref = db.collection("reportList").addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
         
            //通報完了のメッセージ
            GlobalViewModel.shared.setAlertMessage(message: Const.msg_notice_report)
            
            
        } catch {
            print("Error encoding SharedModel: \(error)")
        }
    }

}
