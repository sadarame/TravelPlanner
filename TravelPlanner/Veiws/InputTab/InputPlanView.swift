//
//  InputTextView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI

struct InputPlanView: View {
    
    @Binding var selectedTab: Int
    @Binding var canSwipe: Bool
    @ObservedObject var vm:InputPlanVM
    
    @EnvironmentObject var appState:AppState
    
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        self._selectedTab = selectedTab
        self._canSwipe = canSwipe
        self.vm = InputPlanVM(selectedTab: selectedTab,canSwipe: canSwipe)
      }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // MARK: - 入力エリア
                TextEditor(text: $appState.txt)
                    .frame(height: geometry.size.height * 0.8)
                    .overlay(alignment: .topLeading) {
                        // 未入力の時、プレースホルダーを表示
                        if appState.txt.isEmpty {
                            Text(Const.msg_placeholder)
                                .allowsHitTesting(false) // タップ判定を無効化
                                .foregroundColor(Color(uiColor: .placeholderText))
                                .padding(6)
                        }
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    }
                
                //ボタンエリア
                HStack{
                    // MARK: - FMTボタンエリア
                    VStack{
                        Button("ボタン") {
                            // ボタンがタップされたときの処理を追加
                        }		
                        .buttonStyle(CustomButtonStyle())
                        Button("ボタン") {
                            // ボタンがタップされたときの処理を追加
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    VStack{
                        Button("ボタン") {
                            // ボタンがタップされたときの処理を追加
                        }
                        .buttonStyle(CustomButtonStyle())
                        Button("ボタン") {
                            // ボタンがタップされたときの処理を追加
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    
                    Spacer()
                    
                    // MARK: - 送信ボタンエリア
                    HStack{
                        //クリアボタン
                        CustomButton(label:"クリア",
                                     action: {
                            appState.txt = ""
                        })
                        //作成ボタン
                        CustomButton(label: "作成") {
                            vm.createTravelPlan(txt: appState.txt)
                        }
                    }
                    
                    .frame(height: geometry.size.height * 0.2)
                }
            }
            .onAppear(perform: vm.onloadView)
            .padding()
            //共通モディファイア
            .modifier(CommonModifier(vm: vm))
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(configuration.isPressed ? Color.gray.opacity(0.5) : Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

struct CustomButton: View {
    var label: String
    var action: () -> Void

    var body: some View {
        Button(label, action: action)
            .buttonStyle(CustomButtonStyle())
    }
}
