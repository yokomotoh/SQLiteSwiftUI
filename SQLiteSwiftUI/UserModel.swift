//
//  UserModel.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var username: String = ""
    public var email: String = ""
    public var age: Int64 = 0
    public var price: Int64 = 0
}
