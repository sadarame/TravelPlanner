//
//  TestClendar.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/11/29.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var vm: CalendarVM
    
    
    @State private var scroll_num = 13
    
    //横幅の母数
    let population:CGFloat = 10
    //時間列の横幅の割合
    let widthTimeArea:CGFloat = 2
    //スケジュール列の横幅
    let widthScheduleArea:CGFloat = 8
    //文字サイズ
    let font_size_time:CGFloat = 18
    
    
    
    let height_half_cell:CGFloat = 2
    
    //ボタンの高さ用
    
    let weight_cell_button:CGFloat = 0.9
    let height_header:CGFloat = 50
    
    init() {
        CalendarVM.shared.durlation = 1
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollViewReader { reader in
                //ヘッダーエリア
                VStack{
                    //ヘッダー
                    HStack(spacing: 0){
                        ForEach(0...vm.durlation, id: \.self) { day in
                            Divider()
                            //時間列
                            if day == 0 {
                                Text("")
                                    .frame(width: geometry.size.width * widthTimeArea / population)
                                //一日目
                            } else  {
                                Text("\(day)日目")
                                    .multilineTextAlignment(.center)
                                    .frame(width: (geometry.size.width * widthScheduleArea / population) / CGFloat(vm.durlation))
                            }
                        }
                    }
                    //headerの高さ
                    .frame(height: height_header)
                    //下線を引く
                    .overlay(Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.5)), alignment: .bottom) //
                    
                    ScrollView{
                        //スケジュール
                        HStack(spacing:0){
                            ForEach(0...vm.durlation, id: \.self) { day in
                                //スケジュール帳
                                Divider()
                                ZStack{
                                    VStack(spacing:0){
                                        //タイムライン
                                        ForEach(0..<24, id: \.self) { hour in
                                            //時間軸
                                            if day == 0 {
                                                Text("\(hour):00")
                                                    .font(.system(size: font_size_time))
                                                    .frame(width: geometry.size.width * widthTimeArea / population, height: vm.height_cell)
                                                    .id(hour)
                                                
                                                
                                                //一日目
                                            } else {
                                                Rectangle()
                                                    .foregroundColor(Color.gray.opacity(0.5)) // 透明にする
                                                    .frame(height: 1)
                                                    .frame(width: (geometry.size.width * widthScheduleArea / population) / CGFloat(vm.durlation), height: vm.height_cell)
                                                
                                            }
                                        }
                                    }
                                    //時間列以外の場合
                                    if day != 0 {
                                        
                                        ForEach(vm.getPlansForDayOne(days: day), id: \.self) { plan in
                                            // ボタンエリア
                                            ScheduleButton(dayPlan: plan)
                                                .frame(width: (geometry.size.width * widthScheduleArea / population) / CGFloat(vm.durlation) * weight_cell_button, height: vm.calcButtonHeight(plan: plan))
                                                .offset(x: 0 / population, y: -100)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    .onAppear {
                        // スクロール位置
                        reader.scrollTo(scroll_num, anchor: .center)
                    }
                }
            }
        }
    }
}
struct ScheduleButton: View {
    var dayPlan: DayPlanModel
    
    var body: some View {
        Button(action: {
            // Handle button tap, e.g., navigate to detail view
        }) {
            // カスタムデザインのボタンに変更
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text(dayPlan.title)
                    .foregroundColor(.white)
                //                    .padding()
            }
        }
    }
}

