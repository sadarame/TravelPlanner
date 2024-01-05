//
//  InputScheduleView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds

struct BaseTabView: View {
    
    @State private var selectedTab: Int = 0
    @ObservedObject var vm:BaseVM = BaseVM()
    
//    let list: [String] = [Const.label_tab_input, Const.label_tab_hist, Const.label_tab_reponse, Const.label_tab_othersPlan]
    let list: [String] = [Const.label_tab_input, Const.label_tab_hist, Const.label_tab_othersPlan]

    var body: some View {
        
        VStack(spacing: 0) {
            Divider()
            
            TopTabView(list: list, selectedTab: $selectedTab)
            //広告表示
            AdMobBannerView()
                .frame(height: 50)
            
            
            TabView(selection: $selectedTab,
                    content: {
                //入力画面
                InputPlanView(selectedTab: $selectedTab)
                    .tag(0)
                //履歴画面
                HistoryView(selectedTab: $selectedTab)
                    .tag(1)
                //応答結果画面（GPTの結果を返す画面）
//                ResponseView(selectedTab: $selectedTab)
//                    .tag(2)
                //共有画面（他の入力した旅行の計画をみれる画面）
                SharedView(selectedTab: $selectedTab)
                    .tag(2)
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            // トラッキングの許諾ダイアログメッセージを表示
            Task {
                let result = await ATTrackingManager.requestTrackingAuthorization()
                if result == .authorized {
                    GADMobileAds.sharedInstance().start(completionHandler: nil)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
