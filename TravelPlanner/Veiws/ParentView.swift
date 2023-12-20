//
//  ParentView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI

struct ParentView: View {

    // タブの選択項目を保持する
    @EnvironmentObject var gvm: GlobalViewModel
    //リワード広告用
    @ObservedObject var reward = Reward()

    var body: some View {
        

        TabView(selection: $gvm.selection) {
                
                BaseTabView()   // Viewファイル①
                    .tabItem {
                        Label("入力", systemImage: "rectangle.and.pencil.and.ellipsis")
                    }
                    .tag(1)
                
                CalendarView()   // Viewファイル②
                    .tabItem {
                        Label("予定表", systemImage: "calendar")
                    }
                    .tag(2)
            }
        .onAppear{
            //マスタデータの読み込み
            gvm.fetchFireStore()
            //リワード広告の読み込み
            reward.LoadReward()
            
        }

        //お知らせ用のアラート
        .alert(isPresented: $gvm.isShowMessage) {
            Alert(
                title: Text("お知らせ"),
                message: Text(gvm.message),
                dismissButton: .default(Text("OK"))
            )
        }
        //リワード広告用のアラート
        .alert(isPresented: $gvm.isShowAdReward) {
            Alert(
                title: Text("上限超過"),
                message: Text("リワード広告を見て、回数を増やしますか？"),
                primaryButton: .default(Text("OK"), action: {
                    // 広告を表示する
                    reward.ShowReward()
                   
                }),
                secondaryButton: .cancel()
            )
        }
    }
        
    
}
