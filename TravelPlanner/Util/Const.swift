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
    
    //利用規約
    static let URL_USER_AGREEMENT = "https://golira-pochette.com/%e3%80%90%e5%88%a9%e7%94%a8%e8%a6%8f%e7%b4%84%e3%80%91smarttrip"
    
    //プラポリ
    static let URL_PRIVACY_POLICY = "https://golira-pochette.com/smarttrip-%e3%83%97%e3%83%a9%e3%82%a4%e3%83%90%e3%82%b7%e3%83%bc%e3%83%9d%e3%83%aa%e3%82%b7%e3%83%bc"
    
    //画面メッセージ
    static let msg_error_API = String(localized: "通信エラーが発生しました/nやり直してください")
    static let msg_error_json = String(localized:"型変換処理でエラーが発生しました。")
    static let msg_error_common  = String(localized:"エラーが発生しました")
    static let msg_error_limit  = String(localized:"一日の上限数を超えました")
    static let msg_loading  = String(localized:"Loading...\n30秒ほどかかります")
    static let msg_placeholder  = String(localized:"こちらに旅行の計画を入力してください")
    
    static let msg_block  = String(localized:"ユーザーブロック")
    static let msg_report = String(localized:"通報")
    
    
    
    
    //利用規約
    static let MSG_USER_AGREEMENT_TITLE = String(localized: "利用規約")
    static let MSG_USER_AGREEMENT_DETAILE = 
    String(localized: "当アプリ・サービスでは、プライバシーポリシー（個人情報保護方針）及び\nユーザー規約に則って個人情報や利用データ等を取り扱います。\n下記をご確認の上、同意いただける場合には「同意する」をタップしてお進みください。")
    static let MSG_USER_AGREEMENT_LINK1 = String(localized: "プライバシーポリシ")
    static let MSG_USER_AGREEMENT_LINK2 = String(localized: "利用規約")
    
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
    static let textMaxLength:Int = 30
    //sharedから持ってくる行数
    static let fetchlimit = 30
    //旅行計画の入力制限
    static let travelPlanLimit = 500
    
}
