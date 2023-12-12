//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/11/22.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseCore

@main
struct TravelPlannerApp: App {
    
    @StateObject private var appState = AppState()
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ParentView()
                .environmentObject(appState)
                .environmentObject(GlobalViewModel.shared)

        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
