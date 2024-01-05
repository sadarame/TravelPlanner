//
//  BaseVM.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseFirestore

class BaseVM: NSObject, ObservableObject {
    
    // MARK: - AppStore遷移
    func openAppStore() {
        guard let appStoreURL = URL(string: "https://itunes.apple.com/app/6459478923") else {
            return
        }
        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }

    //引数ありでAPIコールする用のメソッド
    func fetchDataFromAPI<T: Decodable>(url: String, jsonData:Data, completion: @escaping (Result<T, Error>) -> Void) {
        
        GlobalViewModel.shared.isDisEditable = true
        GlobalViewModel.shared.isShowProgres = true
        
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
                GlobalViewModel.shared.isShowProgres = false
                GlobalViewModel.shared.isDisEditable = false
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
