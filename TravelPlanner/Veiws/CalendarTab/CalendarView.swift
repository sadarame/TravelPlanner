//
//  TestClendar.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/11/29.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 日付エリア
                HStack {
                    VStack{
                        Text("")
                    }
                    .frame(width: geometry.size.width / 10)
                    
                    
                    ForEach(0..<3) { yobi in
                        VStack {
                            Text("")
                            Text("\(yobi+1)日")
                            Text("\(yobi+1)曜日")
                        }
                        .frame(width: geometry.size.width * 3 / 10) // 画面の幅を3分割したサイズ
                    }
                }
                
                ScrollView {
                    VStack(spacing:0) {
                        //時間のループ
                        ForEach(0..<24) { hour in
                            
                            HStack(spacing:0) {
                                Text("\(String(format: "%02d", hour))時")
                                                 .frame(width: geometry.size.width / 10, height: 150) // 画面の幅を4分割したサイズ
                                            
                                
                                HStack(spacing:0) {
                                    ForEach(0..<3) { s in
                                        Text("\(s)")
                                            .frame(width: geometry.size.width * 3 / 10,height: 150) //
                                            .border(Color.gray.opacity(0.5), width: 1)
//                                        画面の幅を3分割したサイズ
                                    }
                                }
                                .border(Color.gray.opacity(0.5), width: 1)
                                // 一日目のコンテンツを追加する部分
                            }
            
                        }
                    }
                    
                }
            }
            .navigationTitle("スケジュール")
        }
    }
}

