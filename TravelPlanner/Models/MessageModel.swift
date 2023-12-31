//
//  NotificateMessageModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MessageModel: Identifiable, Codable {
    @DocumentID var id: String?
    var message: String
    var en_message: String
    var createAt: Date
    var dateFrom: Date
    var dateTo: Date
}
