//
//  ReportVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/22.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ReportVM: BaseVM {
    
    @Published var model = ReportModel()
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var isError = false
    
    override init() {
    }
    
    func sendReport() {
        //ユーザーID設定
        model.reportID = GlobalViewModel.shared.reportID
        model.userID = loadDocumentID() ?? ""
        
        
        if model.reportContent.isEmpty {
            alertMessage = Const.label_report_alert_message
            isError = true
        } else {
            // Firestoreにデータを書き込む
            addReportToFirestore()
        }
        showAlert = true
    }

    private func addReportToFirestore() {
        let db = Firestore.firestore()
        do {
            // Firestoreに追加するデータ
            var reportData = try model.toFirestoreData()
            
            // Firestoreのコレクションに追加
            db.collection("TB_USER_REPORT").addDocument(data: reportData) { error in
                if let error = error {
                    self.alertMessage = "データの書き込みに失敗しました。エラー: \(error.localizedDescription)"
                    self.isError = true
                } else {
                    self.alertMessage = Const.label_report_completed
                }
                self.showAlert = true
            }
        } catch {
            self.alertMessage = "データの変換に失敗しました。エラー: \(error.localizedDescription)"
            self.isError = true
            self.showAlert = true
        }
    }
}
