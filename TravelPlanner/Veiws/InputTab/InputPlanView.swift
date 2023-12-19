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
    @ObservedObject var vm: InputPlanVM
    @EnvironmentObject var appState: AppState
    
    @Environment(\.scenePhase) private var scenePhase
    
    init(selectedTab: Binding<Int>, canSwipe: Binding<Bool>) {
        self._selectedTab = selectedTab
        self._canSwipe = canSwipe
        self.vm = InputPlanVM(selectedTab: selectedTab, canSwipe: canSwipe)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                durationPicker()
                    .frame(height: geometry.size.height * 0.05)
                
                inputArea()
                    .frame(height: geometry.size.height * 0.7)
                
                characterCountView()
                    .frame(height: geometry.size.height * 0.01)
                
                buttonArea()
//                    .frame(height: geometry.size.height * 0.25)
//                    .padding(.bottom)
            }
            .padding()
            .onAppear(perform: vm.onloadView)
            .modifier(CommonModifier(vm: vm))
            .onChange(of: scenePhase) { phase in
                if phase == .background {
                    canSwipe = true
                }
            }
        }
    }
    
    private func durationPicker() -> some View {
        HStack {
            Text("旅行日数を選択")
                .padding()
            
            Picker("日数を選択", selection: $vm.model.travelDuration) {
                Text("1日").tag(1)
                Text("2日").tag(2)
                Text("3日").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private func inputArea() -> some View {
        TextEditor(text: $appState.txt)
            
            .overlay(alignment: .topLeading) {
                if appState.txt.isEmpty {
                    placeholderView()
                }
                borderView()
            }
            .onChange(of: appState.txt) {
                if appState.txt.count > Const.travelPlanLimit {
                    appState.txt = String(appState.txt.prefix(Const.travelPlanLimit))
                }
            }
            .toolbar {
                keyboardToolbar()
            }
    }
    
    private func placeholderView() -> some View {
        Text(Const.msg_placeholder)
            .allowsHitTesting(false)
            .foregroundColor(Color(uiColor: .placeholderText))
            .padding(6)
    }
    
    private func borderView() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
    }
    
    private func keyboardToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button("閉じる") {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    private func characterCountView() -> some View {
        HStack {
            Spacer()
            Text("文字数: \(String(format: "%03d", appState.txt.count))/\(Const.travelPlanLimit)")
                .foregroundColor(appState.txt.count > Const.travelPlanLimit ? .red : .primary)
        }
    }
    
    private func buttonArea() -> some View {
        HStack {
            fmtButtonArea()
            
            Spacer()
            
            sendButtonArea()
        }
        
    }
    
    private func fmtButtonArea() -> some View {
        VStack {
            Button("ボタン") {
                // ボタンがタップされたときの処理を追加
            }
            .buttonStyle(CustomButtonStyle())
            Button("ボタン") {
                // ボタンがタップされたときの処理を追加
            }
            .buttonStyle(CustomButtonStyle())
        }
    }
    
    private func sendButtonArea() -> some View {
        HStack {
            CustomButton(label: "クリア") {
                appState.txt = ""
            }
            
            CustomButton(label: "作成") {
                vm.createTravelPlan(txt: appState.txt)
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
