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
    @Published var tabSelected: Tab = .product
    @Published var productSelected: Int?
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
        
    }
    
    func checkDeepLink(url: URL) {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return
        }
        
        print(host)
        if host.contains(Tab.product.rawValue) {
            tabSelected = .product
            let id = host.replacingOccurrences(of: "product=", with: "")
            productSelected = Int(id)
        } else if host.contains(Tab.user.rawValue) {
            tabSelected = .user
        } else if host.contains(Tab.setting.rawValue) {
            tabSelected = .setting
        }
        
    }
}
