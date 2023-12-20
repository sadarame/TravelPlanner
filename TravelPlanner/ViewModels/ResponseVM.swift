//
//  ResponseVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
import SwiftUI


class ResponseVM: BaseVM {
    
    @Published var gptText:String = ""
    
    override init() {
        super.init() 
        self.onloadView()
    }
    
    func onloadView(){
        gptText = loadGptText() ?? ""
    }
}
