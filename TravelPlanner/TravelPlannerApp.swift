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
import GoogleMobileAds
import FirebaseMessaging
import UserNotifications

@main
struct TravelPlannerApp: App {
    
    @StateObject private var appState = AppState()
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
                ParentView()
                    .environmentObject(appState)
                    .environmentObject(GlobalViewModel.shared)
                    .environmentObject(GlobalCalendarVM.shared)
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })

        application.registerForRemoteNotifications()

        Messaging.messaging().token { token, error in
            if let error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token {
                print("FCM registration token: \(token)")
            }
        }

        return true
    }
    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Oh no! Failed to register for remote notifications with error \(error)")
        }

        func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            var readableToken = ""
            for index in 0 ..< deviceToken.count {
                readableToken += String(format: "%02.2hhx", deviceToken[index] as CVarArg)
            }
            print("Received an APNs device token: \(readableToken)")
        }
}

extension AppDelegate: MessagingDelegate {
    @objc func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase token: \(String(describing: fcmToken))")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent _: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .list, .sound]])
    }

    func userNotificationCenter(
        _: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        NotificationCenter.default.post(
            name: Notification.Name("didReceiveRemoteNotification"),
            object: nil,
            userInfo: userInfo
        )
        completionHandler()
    }
}
