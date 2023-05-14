//
//  User.swift
//  pushNotification
//
//  Created by Irfan Izudin on 14/05/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: UserName
    let email: String
}

struct UserName: Codable {
    let firstname: String
    let lastname: String
}
