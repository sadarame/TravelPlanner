//
//  ParentView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI



struct ParentView: View {

    // タブの選択項目を保持する
    @State var selection = 1

    var body: some View {

            
            TabView(selection: $selection) {
                
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
        }
    
}
