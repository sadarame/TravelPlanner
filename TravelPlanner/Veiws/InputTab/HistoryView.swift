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
    
    @EnvironmentObject var appState: AppState
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.vm = HistoryVM(selectedTab: selectedTab)
    }
    
    var body: some View {
        List(vm.planHistList) { plan in
            VStack(alignment: .leading) {
                Text(plan.text)
                    .font(.headline)
                Text("日時: \(formattedDate(plan.date))")
                    .font(.subheadline)
            }
            .onTapGesture {
                // リストアイテムがタップされたときの処理
                vm.tapToList(txt: plan.text)
            }
        }
        
    }
    //日付
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
