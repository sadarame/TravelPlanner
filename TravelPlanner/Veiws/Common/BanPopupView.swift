//
//  PopupView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/12.
//

import Foundation
import SwiftUI
import SafariServices

struct BanPopupView: View {
    @Binding var isPresent: Bool
    @State private var agreedToTerms: Bool = false // 利用規約に同意したかどうか
    
    var body: some View {
        ZStack {
            // グレー色の背景を全体に適用
            
            
            VStack {
                Spacer() // 上部の余白を作成
                
                VStack(spacing: 12) {
                    Text(Const.msg_error_BAN)
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





