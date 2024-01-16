//
//  PopupView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/12.
//

import Foundation
import SwiftUI
import SafariServices

struct AgreementPopupView: View {
    @Binding var isPresent: Bool
    @State private var agreedToTerms: Bool = false // 利用規約に同意したかどうか
    
    var body: some View {
        ZStack {
            // グレー色の背景を全体に適用
            
            
            VStack {
                Spacer() // 上部の余白を作成
                
                VStack(spacing: 12) {
                    Text(Const.MSG_USER_AGREEMENT_TITLE)
                        .font(Font.system(size: 18).bold())
                    
                    Text(Const.MSG_USER_AGREEMENT_DETAILE)
                        .font(Font.system(size: 14))
                    
                    // 利用規約のリンク
                    Text(Const.MSG_USER_AGREEMENT_LINK1)
                        .foregroundColor(.blue)
                        .underline()
                        .onTapGesture {
                            guard let url = URL(string: Const.URL_USER_AGREEMENT) else {
                                 return // URLが無効な場合は何もしない
                             }
                             
                             // SFSafariViewControllerを使用してウェブページを開く
                             let safariViewController = SFSafariViewController(url: url)
                             UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
                        }
                        .font(Font.system(size: 14))
                    
                    
                    //プライバシーポリシー表示
                    Text(Const.MSG_USER_AGREEMENT_LINK2)
                        .foregroundColor(.blue)
                        .underline()
                        .onTapGesture {
                            guard let url = URL(string: Const.URL_PRIVACY_POLICY) else {
                                 return // URLが無効な場合は何もしない
                             }
                             
                             // SFSafariViewControllerを使用してウェブページを開く
                             let safariViewController = SFSafariViewController(url: url)
                             UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
                        }
                        .font(Font.system(size: 14))
                    
                    Toggle("利用規約に同意する", isOn: $agreedToTerms)
                    
                    Button(action: {
                        if agreedToTerms {
                            print("利用規約に同意しました。")
                            withAnimation {
                                isPresent = false
                            }
                        } else {
                            print("利用規約に同意してください。")
                        }
                    }, label: {
                        Text("同意する")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(agreedToTerms ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 2)
                )
                
                Spacer() // 下部の余白を作成
            }
        }
        .frame(width: 280, height: 400, alignment: .center) // 高さも指定してみてください
    }
}





