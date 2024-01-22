//
//  ReportFormView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2024/01/22.
//

import SwiftUI

struct ReportFormView: View {
    
    @ObservedObject var vm = ReportVM()
    @EnvironmentObject var gvm: GlobalViewModel
    
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 2) {
                HStack {
                    // 投稿者のユーザーID
                    Text("\(Const.label_report_posted)\(gvm.reportID)")
                        .padding()
                    Spacer()
                }
                
                // 連絡先
                VStack(alignment: .leading, spacing: 1) {
                    Text(Const.label_report_contact)
                        .font(.headline)
                    TextField(Const.label_report_contact_placeholder, text: $vm.model.reporterContact)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                // 通報内容詳細
                VStack(alignment: .leading, spacing: 1) {
                    Text(Const.label_report_desp)
                        .font(.headline)
                    TextEditor(text: $vm.model.reportContent)
                        .overlay(alignment: .topLeading) {
                            if vm.model.reportContent.isEmpty {
                                placeholderView()
                            }
                            borderView()
                        }
                        .cornerRadius(10)
                }
                .padding()

                // 通報ボタン
                Button(action: {
                    vm.model.id = gvm.reportID
                    vm.sendReport()
                }) {
                    Text(Const.label_report_button)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                // アラート
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text(Const.label_report_alert_title), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")) {
                        if !vm.isError {
                            self.isPresented = false // モーダルを閉じる
                        }
                    })
                }

                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = false // モーダルを閉じる
            }) {
                Text(Const.label_report_close_button)
            })
            .navigationBarTitle(Const.label_report_navigation)
        }
    }

    private func placeholderView() -> some View {
        Text(Const.msg_placeholder_report)
            .foregroundColor(Color(uiColor: .placeholderText))
            .padding(6)
    }
    
    private func borderView() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
    }
}


