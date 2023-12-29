//
//  Const.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation
import UIKit

struct Const {
    
    //広告ID（本番）
        static let adUinitIDBanner = "ca-app-pub-5529798279445729/5347935101"
        static let adUinitIDReward = "ca-app-pub-5529798279445729/3090271573"
        static let adUinitIDInter = "ca-app-pub-5529798279445729/6441524927"
    
    //広告ID（テスト）
//    static let adUinitIDBanner = "ca-app-pub-3940256099942544/2934735716"
//    static let adUinitIDReward = "ca-app-pub-3940256099942544/1712485313"
//    static let adUinitIDInter = "ca-app-pub-3940256099942544/4411468910"
    
    //APIの通信先
    static let url_gptAPI = "https://asia-northeast1-travelplanner-e01b4.cloudfunctions.net/python-http-function"
    
    //画面メッセージ
    static let msg_error_API = String(localized: "通信エラーが発生しました/nやり直してください")
    static let msg_error_json = String(localized:"型変換処理でエラーが発生しました。")
    static let msg_error_common  = String(localized:"エラーが発生しました")
    static let msg_error_limit  = String(localized:"一日の上限数を超えました")
    static let msg_loading  = String(localized:"Loading...\n30秒ほどかかります")
    static let msg_placeholder  = String(localized:"こちらに旅行の計画を入力してください")
    
    
    //ラベル
    static let label_create  = String(localized:"日程作成")
    static let label_clear  = String(localized:"クリア")
    static let label_tab_input = String(localized:"入力")
    static let label_tab_hist = String(localized:"履歴")
    static let label_tab_reponse = String(localized:"応答")
    static let label_tab_othersPlan = String(localized:"みんな旅行計画")
    static let label_fmt_1 = String(localized:"定型①")
    static let label_fmt_2 = String(localized:"定型②")
    static let label_fmt_3 = String(localized:"定型③")
    static let label_fmt_4 = String(localized:"定型④")
    
    
    //制御用定数
    //履歴画面のリストの文字数制限
    static let textMaxLength = 15
    //sharedから持ってくる行数
    static let fetchlimit = 30
    //旅行計画の入力制限
    static let travelPlanLimit = 500
    
}
