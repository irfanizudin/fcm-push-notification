//
//  AppViewModel.swift
//  pushNotification
//
//  Created by Irfan Izudin on 08/05/23.
//

import Foundation
import SwiftUI

enum Tab: String {
    case product = "product"
    case user = "user"
    case setting = "setting"
}

class AppViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var product: Product?
    @Published var users: [User] = []
    @Published var user: User?
    @Published var tabSelected: Tab = .product
    @Published var productSelected: Int?
    @Published var userSelected: Int?
    @Published var showUserDetail: Bool = false
    @Published var showNotifSetting: Bool = false
    
    let baseURL = "https://fakestoreapi.com"
    
    func getProducts() {
        guard let url = URL(string: "\(baseURL)/products") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self?.products = result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getProductDetail(id: Int) {
        guard let url = URL(string: "\(baseURL)/products/\(id)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(Product.self, from: data)
                DispatchQueue.main.async {
                    self?.product = result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getUsers() {
        guard let url = URL(string: "\(baseURL)/users") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.users = result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getUserDetail(id: Int) {
        guard let url = URL(string: "\(baseURL)/users/\(id)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self?.user = result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    
    func checkDeepLink(url: URL) {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return
        }
        
        print(host)
        if host.contains(Tab.product.rawValue) {
            tabSelected = .product
            let id = host.replacingOccurrences(of: "product=", with: "")
            print(id)
            productSelected = Int(id)
        } else if host.contains(Tab.user.rawValue) {
            tabSelected = .user
            let id = host.replacingOccurrences(of: "user=", with: "")
            showUserDetail = true
            userSelected = Int(id)
        } else if host.contains(Tab.setting.rawValue) {
            tabSelected = .setting
            let id = host.replacingOccurrences(of: "setting=", with: "")
            if id == "notif" {
                showNotifSetting = true
            }
        }
        
    }
    
    func sendPushNotification() {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }

        let apiKey = APIKey.FCMAPIKey

        let notification: [String: Any] = [
            "to": APIKey.deviceToken,
            "notification": [
                "title": "Storepedia 🚀",
                "body": "New Incoming Product !!!"
            ],
            "data": [
                "link": "app://product=3"
            ]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: notification, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending FCM notification: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("FCM notification sent successfully.")
                } else {
                    print("Failed to send FCM notification. Status code: \(response.statusCode)")
                }
            }
        }
        
        task.resume()
    }
}

