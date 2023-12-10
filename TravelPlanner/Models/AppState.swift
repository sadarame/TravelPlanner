//
//  AppState.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/07.
//

import Foundation
//import FirebaseFirestoreSwift


class AppState: ObservableObject {
    @Published var isDisEditable = false
    @Published var selection = 1
    @Published var txt = ""
}
