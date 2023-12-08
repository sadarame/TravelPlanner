//
//  HistoryVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import SwiftUI

class HistoryVM: BaseVM {
    
    @Binding var selectedTab: Int
    @Published var planHistList:[TravelPlanModel]
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        self.planHistList = loadTravelPlanHistList() ?? []
    }
    
    func onloadView() {
        planHistList = loadTravelPlanHistList() ?? []
    }
    
}
