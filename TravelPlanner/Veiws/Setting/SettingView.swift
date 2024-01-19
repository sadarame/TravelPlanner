//
//  SettingView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/19.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    @State private var receiveNotifications = true
    @State private var selectedThemeIndex = 0
    @State private var selectedLanguageIndex = 0
    @State private var isShowingInquiryForm = false
    @State private var isShowingMailComposer = false
    @State var isShowMailView = false

    var body: some View {
        NavigationView {
            Form {
                //通知設定、外観設定のセクションは省略
                Section() {
                    Button(action: {
                        
                        if MailView.canSendMail() {
                            isShowMailView = true
                        } else {
                            // MailViewを表示できない
                            GlobalViewModel.shared.setAlertMessage(message: "メールアプリがありません。")
                        }
                    }) {
                        Text(Const.label_inquiry)
                    }
                }
            }
            .navigationTitle(Const.label_setting)
            .sheet(isPresented: $isShowMailView) {
                  MailView(
                      address: ["sadarame@gmail.com"],
                      subject: Const.mail_subujection,
                      body: ""
                  )
                  .edgesIgnoringSafeArea(.all)
              }
        }

    }
}

