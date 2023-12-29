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
    
    init(selectedTab: Binding<Int>) {
        
        self._selectedTab = selectedTab
        super.init()
        
        self.fetchShared()
    }
    
    func fetchShared() {
        let db = Firestore.firestore()
        let collectionRef = db.collection("Shared")
        
        // timestampフィールドを基準に降順でデータを取得するようにクエリを設定
        collectionRef
            .order(by: "timestamp", descending: true)  // ここでtimestampに対して降順にソート
            .limit(to: Const.fetchlimit)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                } else {
                    // Firestoreから取得したデータをYourDataType型にデコード
                    do {
                        self.data = try querySnapshot?.documents.compactMap { document in
                            try document.data(as: SharedModel.self)
                        } ?? []
                    } catch let error {
                        print("Error decoding data: \(error.localizedDescription)")
                    }
                }
            }
    }

}
