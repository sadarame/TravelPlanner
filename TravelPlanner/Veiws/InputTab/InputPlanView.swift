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
    
    //    @State private var selectedDays = 1
    
    @ObservedObject var vm:InputPlanVM
    @EnvironmentObject var appState:AppState
    
    //バックグランド検知用
    @Environment(\.scenePhase) private var scenePhase
    
    init(selectedTab: Binding<Int>,canSwipe: Binding<Bool>) {
        self._selectedTab = selectedTab
        self._canSwipe = canSwipe
        self.vm = InputPlanVM(selectedTab: selectedTab,canSwipe: canSwipe)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("旅行日数を選択")
                        .padding()
                    Picker("日数を選択", selection: $vm.model.travelDuration) {
                        Text("1日").tag(1)
                        Text("2日").tag(2)
                        Text("3日").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }.frame(height: geometry.size.height * 0.05)
                
                // MARK: - 入力エリア
                TextEditor(text: $appState.txt)
                    .frame(height: geometry.size.height * 0.65)
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
                    .onChange(of: appState.txt) {
                        if appState.txt.count > Const.travelPlanLimit {
                            // 500文字を超える場合は制限
                            appState.txt = String(appState.txt.prefix(Const.travelPlanLimit))
                        }
                    }             
                    //キーボード
                    .toolbar {  // VStackに指定
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()         // 右寄せにする
                            Button("閉じる") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)  //  フォーカスを外す
                            }
                        }
                    }
                HStack {
                    Spacer()
                    Text("文字数: \(String(format: "%03d", appState.txt.count))/\(Const.travelPlanLimit)")
                        .foregroundColor(appState.txt.count > Const.travelPlanLimit ? .red : .primary)
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
                    
                    
                }
                .frame(height: geometry.size.height * 0.10)
                .padding(.bottom)
            }
            
            .onAppear(perform: vm.onloadView)
            .padding()
            //共通モディファイア
            .modifier(CommonModifier(vm: vm))
            .onChange(of: scenePhase) { phase in
                if phase == .background {
                    canSwipe = true
                }
            }
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
