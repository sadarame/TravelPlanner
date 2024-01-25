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
    
    //通報対象
    @Published var reportID:String = ""

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
    
    //プログレスエフェクト表示制御
    @Published var isShowProgres = false
    //利用規約表示
    @AppStorage("isShowTermOfService") var isShowTermOfService = true
    
    //アカウントバンのユーザかどうか
    @Published var isBlocked = false
    
    //エラーメッセージ制御
    @Published var isShowingMessage: Bool = false
    @Published var userMessage: String = ""
    //画面制御
    @Published var isDisEditable:Bool = false
    
    @Published var reward = Reward()
    @Published var adMobInterstitialView = AdMobInterstitialView()
    
    private init() {
        //リワード広告の読み込み
        reward.LoadReward()
        adMobInterstitialView.loadInterstitial()
    }
    
    func fetchFireStore() {
        //マスタデータの取得
        fetchMstData()
        //マスタデータの取得
        fetchUserNotificationMessage()
        //ブロック
        isBlockedUser()
    }
    
    func isBlockedUser() {
        guard let userId = loadDocumentID() else {
            // userIdがnilの場合の処理
            return
        }

        // 指定したuseridのデータを取得
        fetchDataFromFirestore(userId: userId) { result in
            switch result {
            case .success(let document):
                // ドキュメントが取得できた場合の処理
                let data = document.data()
                print("Fetched data: \(data ?? [:])")
                
                self.isBlocked = true
                
                
            case .failure(let error):
                // エラーが発生した場合の処理
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
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
                    
                    //localrization
                    self?.message = self!.localizingFormatModel(model: userMessage)

                    self?.lastUserMessageID = userMessage.id ?? ""
                }
            }
        }
    }
    
    func localizingFormatModel(model:MessageModel) -> String {
        let currentLocale = Locale.current
        let languageCode = currentLocale.languageCode ?? "ja"
        
        switch languageCode {
        case "ja":
            return model.message
        case "en":
            return model.en_message
        default:
            return model.message
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
    
    func fetchDataFromFirestore(userId: String, completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("TB_BLOCK_USERS")

        // 指定したuseridのデータを取得
        let query = collection.whereField("userID", isEqualTo: userId)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                // ドキュメントが存在しない場合の処理
                let customError = NSError(domain: "FirestoreErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
                completion(.failure(customError))
                return
            }

            if documents.isEmpty {
                // ドキュメントが見つからない場合の処理
                let customError = NSError(domain: "FirestoreErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
                completion(.failure(customError))
                return
            }

            // ドキュメントが存在する場合、最初のドキュメントを返す
            if let document = documents.first {
                completion(.success(document))
            } else {
                // ドキュメントが存在しない場合の処理
                let customError = NSError(domain: "FirestoreErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
                completion(.failure(customError))
            }
        }
    }
    
    
}

