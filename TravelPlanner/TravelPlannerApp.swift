//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/11/22.
//

import SwiftUI
import Firebase
import UIKit
import FirebaseCore

@main
struct TravelPlannerApp: App {
    
    @StateObject private var appState = AppState()
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ParentView()
                .environmentObject(appState)
                .onAppear {
                    getMstData()
                }
        }
    }
    private func getMstData() {
        // データを取得する処理
        // ...
        
        // 取得したデータを AppState に設定する
        appState.mstData.someData = "データを取得した結果"
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
