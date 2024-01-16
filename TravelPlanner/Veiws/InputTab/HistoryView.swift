//
//  HistoryView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var vm: HistoryVM
    @Binding var selectedTab: Int
    @EnvironmentObject var appState: AppState
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.vm = HistoryVM(selectedTab: selectedTab)
    }
    
    var body: some View {
        List {
            ForEach(vm.planHistList.reversed()) { plan in
                VStack(alignment: .leading) {
                    Text(String(plan.planTitle.prefix(Const.textMaxLength)))
                        .font(.headline)
                    Text("\(plan.timeAgoSinceDate())")
                        .font(.subheadline)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    // リストアイテムがタップされたときの処理
                    appState.txt = plan.text
                    selectedTab = 0
                }
                .contextMenu {
                    Button(action: {
                        // リストアイテムが削除されたときの処理
                        if let index = vm.planHistList.firstIndex(where: { $0.id == plan.id }) {
                             vm.deletePlan(at: index)
                         }
//
                    }) {
                        Text("削除")
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}


