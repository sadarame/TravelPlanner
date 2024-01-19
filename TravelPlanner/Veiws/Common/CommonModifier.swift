//
//  CommonModifier.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import SwiftUI

struct CommonModifier: ViewModifier {
    
    @EnvironmentObject var gvm: GlobalViewModel
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(gvm.isDisEditable)
            
            //処理中の画像表示
            if gvm.isShowProgres {
                ProgressView(Const.msg_loading)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
            }
            
            //利用規約の表示
            if gvm.isShowTermOfService {
                Color.gray.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                AgreementPopupView(isPresent: $gvm.isShowTermOfService)
            }
                
        }
        .alert(isPresented: Binding<Bool>.constant($gvm.isShowMessage.wrappedValue || $gvm.isShowAdReward.wrappedValue)) {
            if gvm.isShowMessage {
                return Alert(
                    title: Text("お知らせ"),
                    message: Text(gvm.message),
                    dismissButton: .default(Text("OK"))
                )
            } else if gvm.isShowAdReward {
                return Alert(
                    title: Text("上限超過"),
                    message: Text("リワード広告を見て、回数を増やしますか？"),
                    primaryButton: .default(Text("OK"), action: {
                        // 広告を表示する
                        gvm.reward.ShowReward()
                    }),
                    secondaryButton: .cancel()
                )
            }

            // ここにデフォルトのAlertを返すか、エラー処理を追加するなど必要に応じて対応してください
            return Alert(title: Text("エラー"), message: Text("予期せぬエラーが発生しました。"), dismissButton: .default(Text("OK")))
        }


//        .alert(isPresented: $gvm.isShowMessage) {
//            Alert(
//                title: Text("お知らせ"),
//                message: Text(gvm.message),
//                dismissButton: .default(Text("OK"))
//            )
//        }
        //リワード広告用のアラート
//        .alert(isPresented: $gvm.isShowAdReward) {
//            
//            Alert(
//                title: Text("上限超過"),
//                message: Text("リワード広告を見て、回数を増やしますか？"),
//                primaryButton: .default(Text("OK"), action: {
//                    // 広告を表示する
//                    gvm.reward.ShowReward()
//                   
//                }),
//                secondaryButton: .cancel()
//            )
//        }

    }
}
