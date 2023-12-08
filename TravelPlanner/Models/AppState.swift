//
//  AppState.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import FirebaseFirestore

class AppState: ObservableObject {
    @Published var isDisEditable = false
    @Published var selection = 1
    @Published var txt = ""
    
    @Published var mstData = MstData()
    @Published var userNotificate = UserNotificate()
    @Published var errorMessage = ""
    
    func getMstData() {
        let docRef = db.collection("MstData").document("QwuCnUTJr3sQ7zYQbbgY")
        
        docRef.getDocument(as: MstData.self) { result in
            switch result {
            case .success(let book):
                // A Book value was successfully initialized from the DocumentSnapshot.
                self.mstData = book
                self.errorMessage = nil
            case .failure(let error):
                // A Book value could not be initialized from the DocumentSnapshot.
                self.errorMessage = "Error decoding document: \(error.localizedDescription)"
            }
        }
    }
    
}

struct MstData: Identifiable, Codable{
    //Gptのテキスト前につける文字列
    var preTxt = ""
}

struct UserNotificate: Identifiable, Codable {
    @DocumentID var id: String?
    var notificateMessage = ""
    var notificateMessageID = ""
}
