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

    //ユーザメッセージ通知フラグ
    @Published var isShowMessage:Bool = false
    //リワード広告
    @Published var isShowAdReward:Bool = false
    //ユーザメッセージ
    @Published var message:String = ""
    //最後に通知したメッセージIDを保持
    @AppStorage("lastUserMessageID") var lastUserMessageID = ""
    
    //タブ移動用のフラグ
    @Published var selection = 1
    
    private init() {}
    
    func fetchFireStore() {
        //マスタデータの取得
        fetchMstData()
        //マスタデータの取得
        fetchUserNotificationMessage()
    }
    
    func fetchData<T: Decodable>(from collection: String, as type: T.Type, completion: @escaping ([T]) -> Void) {
        let db = Firestore.firestore()
        let collectionRef = db.collection(collection)
        
        // ドキュメントの取得
        collectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion([])
            } else {
                // Firestoreから取得したデータを指定した型にデコード
                do {
                    let data = try querySnapshot?.documents.compactMap { document in
                        try document.data(as: type)
                    } ?? []
                    completion(data)
                } catch let error {
                    print("Error decoding data: \(error.localizedDescription)")
                    completion([])
                }
            }
        }
    }
    
    func fetchUserNotificationMessage() {
        fetchData(from: "UserMessage", as: MessageModel.self) { [weak self] userMessageList in
            //リスト形式をソート
            let userMessage = userMessageList.sorted { $0.createAt > $1.createAt }[0]
            
            DispatchQueue.main.async {
                //最後に通知したメッセージIDと取得してきたIDが一致しない場合
                if self?.lastUserMessageID != userMessage.id ?? "" {

                    self?.isShowMessage = true
                    
                    self?.message = userMessage.message

                    self?.lastUserMessageID = userMessage.id ?? ""
                }
            }
        }
    }
    
    func fetchMstData() {
        fetchData(from: "MstData", as: MstModel.self) { mstModel in
            saveMstData(mstModel.first ?? MstModel())
        }
    }
    
    func setAlertMessage(message:String){
        isShowMessage = true
        self.message = message
    }
    
    func setAdAlertMessage(){
        isShowAdReward = true
    }
}

