//
//  AdMobBannerView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/19.
//

import SwiftUI
import GoogleMobileAds

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 50))) // バナーサイズを指定
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //本番
//        bannerView.adUnitID = "ca-app-pub-5529798279445729/5347935101"
        
        // 新しいウィンドウ取得の方法を使用
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            bannerView.rootViewController = windowScene.windows.first?.rootViewController
        }
        
        bannerView.load(GADRequest())
        return bannerView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {}

    static func sizeThatFits(_ size: CGSize) -> GADAdSize {
        return GADAdSizeFromCGSize(size)
    }
}
