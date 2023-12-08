//
//  CommonModifier.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import SwiftUI

struct CommonModifier: ViewModifier {
    
    @ObservedObject var vm: BaseVM
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            //処理中の画像表示
            if vm.isShowProgres || !vm.canSwipe {
                ProgressView(Const.msg_loading)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
        //エラーメッセージ
        .alert(isPresented: $vm.isShowingMessage) {
            Alert(title: Text("Error"), message: Text(vm.userMessage), dismissButton: .default(Text("OK"),action: {
                vm.hideUserMessage()
            }))
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
        
        .disabled(vm.isDisEditable)
    }
}
