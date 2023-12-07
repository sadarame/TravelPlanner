//
//  BaseVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation
import UIKit
import SwiftUI

class BaseVM: NSObject, ObservableObject {
    
    //プログレスエフェクト表示制御
    @Published var isShowProgres = false
    //エラーメッセージ制御
    @Published var isShowingMessage: Bool = false
    @Published var userMessage: String = ""
    //画面制御
    @Published var isDisEditable:Bool = false
    
//    @Binding var canSwipe: Bool
    
    // MARK: - AppStore遷移
    func openAppStore() {
        guard let appStoreURL = URL(string: "https://itunes.apple.com/app/6459478923") else {
            return
        }
        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }

    
    // ポップアップを表示するメソッド
    func showUserMessage(withMessage message: String) {
        userMessage = message
        isShowingMessage = true
    }
    
    // ポップアップを非表示にするメソッド
    func hideUserMessage() {
        isShowingMessage = false
    }

    //引数ありでAPIコールする用のメソッド
    func fetchDataFromAPI<T: Decodable>(url: String, jsonData:Data, completion: @escaping (Result<T, Error>) -> Void) {
        
        isDisEditable = true
        isShowProgres = true
        
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        //リクエスト作成
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //引数で受け取ったjsonを設定
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.isShowProgres = false
                self.isDisEditable = false
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum APIError: Error {
    case invalidURL
    case noData
}

func logData(_ data: Data) {
    if let jsonString = String(data: data, encoding: .utf8) {
        print(jsonString)
    } else {
        print("Invalid data")
    }
    

}
