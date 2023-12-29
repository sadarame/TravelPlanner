//
//  SharedModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/13.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SharedModel: Identifiable, Codable {
    @DocumentID var id: String?
    var input_message: String
    var response_message: String
    var user_id: String
    var timestamp: Date

}
