//
//  InputScheduleView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI

struct BaseTabView: View {
    
    
    @State private var selectedTab: Int = 0
    @State private var canSwipe: Bool = false

    let list: [String] = ["入力", "履歴", "応答", "みんな旅行計画"]

    var body: some View {
        
        VStack(spacing: 0) {
            Divider()
            TopTabView(list: list, selectedTab: $selectedTab)
            TabView(selection: $selectedTab,
                    content: {
                //入力画面
                InputPlanView(selectedTab: $selectedTab)
                    .tag(0)
                //履歴画面
                HistoryView(selectedTab: $selectedTab)
                    .tag(1)
                //応答結果画面（GPTの結果を返す画面）
                ResponseView(selectedTab: $selectedTab)
                    .tag(2)
                //共有画面（他の入力した旅行の計画をみれる画面）
                //大変そうだからPhase２行きかな
                SharedView()
                    .tag(3)
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .disabled(!canSwipe)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Test")
    }
}
