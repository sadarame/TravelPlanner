//
//  ButtonPressModel.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/12.
//

import Foundation

struct ButtonPressModel: Codable {
    
    var buttonPressCount: Int {
        didSet {
            updateIsOverMaxCount()
        }
    }
    var lastPressDate: Date
    var maxButtonPress: Int
    var isOverMaxCount: Bool {
        didSet {
            // isOverMaxCountが変更されたときの処理
            if isOverMaxCount {
                print("ボタンの制限回数を超えました。")
            }
        }
    }

    init() {
        buttonPressCount = 0
        maxButtonPress = loadMstData().MaxLimit
        lastPressDate = Date()
        isOverMaxCount = false
    }

    private mutating func updateIsOverMaxCount() {
        isOverMaxCount = buttonPressCount > maxButtonPress
    }
}
