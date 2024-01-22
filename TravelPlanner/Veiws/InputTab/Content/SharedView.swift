//
//  SharedView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct SharedView: View {
    @ObservedObject var vm:SharedVM
    @Binding var selectedTab: Int
    @EnvironmentObject var appState:AppState
    @EnvironmentObject var gvm: GlobalViewModel
    
    
    //通報view制御フラグ
    @State private var isReportFormPresented = false
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.vm = SharedVM(selectedTab: selectedTab)
    }
    
    var body: some View {
        List(vm.data, id: \.id) { plan in
            HStack{
                
                VStack(alignment: .leading) {
                    Text(String(plan.getPlanTitle().prefix(Const.textMaxLength)))
                        .font(.headline)
                    Text("\(plan.timeAgoSinceDate())")
                        .font(.subheadline)
                }
                .onTapGesture {
                    // リストアイテムがタップされたときの処理
                    appState.txt = plan.input_message
                    selectedTab = 0
                }
                Spacer()
                Menu {
                    //ブロック
                    Button(action: {
                        vm.blockingUser(blockID: plan.user_id)
                    }) {
                        Text(Const.label_block)
                        Image(systemName: "exclamationmark.octagon")
                    }
                    //通報イベント
                    Button(action: {
//                        vm.reportUser(sharedModel: plan)
                        
                        gvm.reportID = plan.user_id
                        isReportFormPresented = true
                    }) {
                        Text(Const.label_report)
                        Image(systemName: "exclamationmark.bubble")
                        
                    }
                } label: {
                    Label("︙", systemImage: "")
                }
            }
            
            .contentShape(Rectangle())
            
            
        }
        //下に引っ張るやつ
        .refreshable(action: vm.fetchShared)
        .onAppear(perform: vm.fetchShared)
        .listStyle(.plain)
        .sheet(isPresented: $isReportFormPresented) {
            //通報フォーム
            ReportFormView(isPresented: $isReportFormPresented)
        }
    }
    
    //日付
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

