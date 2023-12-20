//
//  Reward.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/20.
//

import Foundation
import GoogleMobileAds
import SwiftUI

class Reward: NSObject, GADFullScreenContentDelegate, ObservableObject {
    @Published var rewardLoaded: Bool = false
    @AppStorage("isShowedReward") var isShowedReward: Bool = false
    var rewardedAd: GADRewardedAd?

    override init() {
        super.init()
    }

    // リワード広告の読み込み
    func LoadReward() {
        //本番
//        let unitID = "ca-app-pub-5529798279445729/3090271573"
        //テスト
        let unitID = "ca-app-pub-3940256099942544/1712485313"
        
        GADRewardedAd.load(withAdUnitID: unitID, request: GADRequest()) { (ad, error) in
            if let _ = error {
                print("😭: 読み込みに失敗しました")
                self.rewardLoaded = false
                return
            }
            print("😍: 読み込みに成功しました")
            self.rewardLoaded = true
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }

    // リワード広告の表示
    func ShowReward() {
        let root = UIApplication.shared.windows.first?.rootViewController
        if let ad = rewardedAd {
            ad.present(fromRootViewController: root!, userDidEarnRewardHandler: {
                print("😍: 報酬を獲得しました")
                
                self.rewardLoaded = false
                //報酬ゲット
                self.isShowedReward = true
            })
        } else {
            print("😭: 広告の準備ができていませんでした")
            self.rewardLoaded = false
            self.LoadReward()
        }
    }
}
