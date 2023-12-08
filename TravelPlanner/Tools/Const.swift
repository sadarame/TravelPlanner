//
//  Const.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation
import UIKit

struct Const {
    
    //APIの通信先
    static let url_gptAPI = "https://asia-northeast1-travelplanner-e01b4.cloudfunctions.net/python-http-function"
    
    //画面メッセージ
    static let msg_error_API = "通信エラーが発生しました/nやり直してください"
    static let msg_error_json = "型変換処理でエラーが発生しました。"
    static let msg_error_common  = "エラーが発生しました"
    static let msg_loading  = "Loading...\n30秒ほどかかります"
    static let msg_placeholder  = "こちらに旅行の計画を入力してください"
    
    //制御用定数
    //履歴画面のリストの文字数制限
    static let textMaxLength = 30
    
    
    
    //画面メッセージ
    static let locationViewMsg1 = "本アプリは位置情報を使用して、ゴミの情報を取得します"
    static let locationViewMsg2 = "位置情報を使用許可してください"
    static let locationViewMsg3 = "位置の取得が完了しました。"
    
    static let INFO_MESSAGE_1 = "本アプリは住所を利用して、\n付近のゴミ情報を取得しにいきます。\n番地は任意です"
    static let INFO_MESSAGE_2 = "付近で使われているゴミ情報が\n使用回数順に表示されています。\n情報は正確ではない場合があるので、地域の情報を確認した上で活用してください。"
    
    static let INFO_MESSAGE_3 = "通知設定がオフになっています。\n設定画面から通知を有効にしてください。"
    
    static let INFO_MESSAGE_4 = "位置情報を取得できませんでした。\nもう一度ボタンを押下してください"
    
    
    
    
    //APIのリクエスト先
    static let URL_API_CALL = "https://golira-pochette.com/GarbageAPI.php"
    static let URL_ZIPCODE_API = "https://zipcloud.ibsnet.co.jp/api/search?zipcode="
    static let API_KEY = "YOSUKE1227"
    
    static let URL_PRIVACY_POLISCY = "https://golira-pochette.com/%e5%85%a8%e5%9b%bd%e3%82%b4%e3%83%9f%e5%87%ba%e3%81%97%e3%82%ab%e3%83%ac%e3%83%b3%e3%83%80%e3%83%bc%e3%83%97%e3%83%a9%e3%82%a4%e3%83%90%e3%82%b7%e3%83%bc%e3%83%9d%e3%83%aa%e3%82%b7%e3%83%bc/"
    
    //画面遷移トリガー
    static let TRG_NEXT_BUTTON = 1
    static let TRG_LIST_TAP = 2
    static let TRG_SIDE_MENU = 3
    
    //ポップアップ呼び元キー情報
    static let KEY_NOTIFICATE = "1"
    
    
    //処理タイプ
    static let TYPE_GET_USER_ID = "1"
    static let TYPE_REGIST_GARBAGE_INFO = "2"
    static let TYPE_REGIST_USER_INFO = "3"
    static let TYPE_GET_GARBAGE_AREA = "4"
    static let TYPE_GET_GARBAGE_INFO = "5"
    
    //画面番号
    static let view_CalendarView = "1"
    //画面制御用
    static let type_NumberPad = "1"
    
    static let show_NavigationView = "1"
    static let hide_NavigationView = "2"
    
    //APIレスポンス用
    static let STATUS_SUCCSESS = "succsess"
    
    //エラー
    static let CODE_ERROR = 1
    static let CODE_NO_ERROR = 0
    
    
    
}
