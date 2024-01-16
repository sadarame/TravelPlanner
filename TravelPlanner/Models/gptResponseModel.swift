//
//  APIRES.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/06.
//

import Foundation

struct gptResponseModel: Decodable {
    let documentId: String
    let sharedId: String
    let responseMessage: String

    enum CodingKeys: String, CodingKey {
        case documentId = "document_id"
        case responseMessage = "response_message"
        case sharedId = "shared_id"
    }
}
