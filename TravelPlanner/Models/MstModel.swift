//
//  MstModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/09.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct MstModel: Codable {
    var MaxLimit: Int = 0
    var json_fmt: String = ""
    var system_message: String = ""
    
    var fmt_sample_1: String  = ""
    var fmt_sample_2: String  = ""
    var fmt_sample_3: String  = ""
    var fmt_sample_4: String  = ""
    
    var fmt_sample_en_1: String  = ""
    var fmt_sample_en_2: String  = ""
    var fmt_sample_en_3: String  = ""
    var fmt_sample_en_4: String  = ""
    
}
