//
//  HistoryView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var vm:HistoryVM
    @Binding var selectedTab: Int
    @EnvironmentObject var appState:AppState
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.vm = HistoryVM(selectedTab: selectedTab)
    }
    
    var body: some View {
        List(vm.planHistList.reversed()) { plan in
            VStack(alignment: .leading) {
                Text(String(plan.text.prefix(Const.textMaxLength)))
                    .font(.headline)
                Text("日時: \(formattedDate(plan.date))")
                    .font(.subheadline)

            }
            .contentShape(Rectangle())
            .onTapGesture {
                // リストアイテムがタップされたときの処理
                appState.txt = plan.text
                selectedTab = 0
            }
        }
    }

    //日付
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
