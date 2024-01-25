//
//  BlockUserModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BlockUserModel: Codable, Identifiable {
    @DocumentID var id: String?
    // FirestoreのドキュメントID
    var userID: String
    var effective_dt_from: Date
    var effective_dt_to: Date
}
