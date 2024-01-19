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
            
            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gearshape.fill")
                }
                .tag(3)
            
            
        }
        .onAppear{
            //マスタデータの読み込み
            gvm.fetchFireStore()
        }
        
        .modifier(CommonModifier())
    }
    
    
}
