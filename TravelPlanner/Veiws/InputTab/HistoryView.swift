//
//  HistoryView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct HistoryView: View {
    @Binding var selectedTab: Int
    @State var inputName = ""   // 状態変数としてTextFieldに紐付け

    var body: some View {
        
        TextField("名前を入力してください", text: $inputName) // ⬅︎
    }
}
