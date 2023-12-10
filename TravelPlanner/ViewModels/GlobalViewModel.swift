//
//  GlobalViewModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/10.
//
import SwiftUI
import FirebaseFirestore

final class GlobalViewModel: ObservableObject {
    static let shared: GlobalViewModel = .init() // シングルトンクラスへ
    @Published var mstModel: [MstModel] = []
    @Published var messsageModel: [MessageModel] = []
    
    @State var isShowMessage:Bool = false
    
    private init() {}
    
    //マスタデータの取得
    func fetchFireStore() {
        fetchMstData()
        fetchUserMessage()
    }
    
    
    func fetchMstData() {
        let db = Firestore.firestore()
        db.collection("MstData").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let documents = querySnapshot?.documents {
                    self.mstModel = documents.compactMap { queryDocumentSnapshot in
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: queryDocumentSnapshot.data())
                            let decoder = JSONDecoder()
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                 print(jsonString)
                             } else {
                                 print("Failed to convert JSON to String.")
                             }
                            let item = try decoder.decode(MstModel.self, from: jsonData)
                            print(jsonData)
                            return item
                        } catch {
                            print("Error decoding document: \(error)")
                            return nil
                        }
                    }
                }
            }
        }
    }
        
    func fetchUserMessage() {
        isShowMessage  = true
        
        let db = Firestore.firestore()
        db.collection("NotoficateMessage").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let documents = querySnapshot?.documents {
                    self.messsageModel = documents.compactMap { queryDocumentSnapshot in
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: queryDocumentSnapshot.data())
                            let decoder = JSONDecoder()
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                 print(jsonString)
                             } else {
                                 print("Failed to convert JSON to String.")
                             }
                            let item = try decoder.decode(MessageModel.self, from: jsonData)
                            print(jsonData)
                            return item
                        } catch {
                            print("Error decoding document: \(error)")
                            return nil
                        }
                    }
                }
            }
        }
    }
}


