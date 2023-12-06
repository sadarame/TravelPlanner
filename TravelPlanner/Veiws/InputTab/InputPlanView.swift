//
//  InputTextView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/04.
//

import SwiftUI

struct InputPlanView: View {
    
    @Binding var selectedTab: Int
    @ObservedObject var vm:InputPlanVM
    
    init(selectedTab: Binding<Int>) {
          self._selectedTab = selectedTab
          self.vm = InputPlanVM(selectedTab: selectedTab)
      }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // MARK: - 入力エリア
                TextEditor(text: $vm.model.text)
                    .frame(height: geometry.size.height * 0.8)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                        
//                    )
                    .overlay(alignment: .topLeading) {
                        // 未入力の時、プレースホルダーを表示
                        if vm.model.text.isEmpty {
                            Text("ここに文字を入力してください。")
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
                        CustomButton(label:"クリア", action: vm.clearText)
                        //作成ボタン
                        CustomButton(label:"作成", action: vm.requestGpt)
                    }
                    
                    .frame(height: geometry.size.height * 0.2)
                }
            }
            .padding()
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
