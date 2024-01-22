//
//  ReportModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ReportModel: Codable, Identifiable {
    @DocumentID var id: String? // FirestoreのドキュメントID
    var reportID: String
    var reporterContact: String
    var reportContent: String
    var userID: String
    let timestamp: Date // 通報のタイムスタンプ

    init(id: String? = nil, reportID: String = "", reporterContact: String = "", reportContent: String = "", timestamp: Date = Date(), userID:String = "") {
        self.id = id
        self.reportID = reportID
        self.reporterContact = reporterContact
        self.reportContent = reportContent
        self.timestamp = timestamp
        self.userID = userID
    }
    
    func toFirestoreData() throws -> [String: Any] {
        let data = try Firestore.Encoder().encode(self)
        guard let dictionary = data as? [String: Any] else {
            throw NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode data"])
        }
        return dictionary
    }
}
