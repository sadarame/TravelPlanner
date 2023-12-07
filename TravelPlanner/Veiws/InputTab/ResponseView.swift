//
//  ResponseView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct ResponseView: View {
    
    @Binding var selectedTab: Int
    @ObservedObject var vm:ResponseVM = ResponseVM()

    var body: some View {
        ScrollView {
            VStack {
                Text(vm.gptText)
            }
            .padding()
            .onAppear(perform: vm.onloadView)
        }
    }
}
