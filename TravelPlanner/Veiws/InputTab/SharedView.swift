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
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.vm = SharedVM(selectedTab: selectedTab)
    }
    
    var body: some View {
        List(vm.data) { plan in
            VStack(alignment: .leading) {
                Text(String(plan.input_message.prefix(Const.textMaxLength)))
                    .font(.headline)
                Text("日時: \(formattedDate(plan.timestamp))")
                    .font(.subheadline)
               
            }
            .contentShape(Rectangle())
            .onTapGesture {
                // リストアイテムがタップされたときの処理
                appState.txt = plan.input_message
                selectedTab = 0
            }
        }.onAppear(perform: vm.fetchShared)
    }

    //日付
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

