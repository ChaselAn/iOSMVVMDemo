//
//  User.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation

struct User: Codable, Equatable {
    var name: String
    var projectCount: Int
    var starCount: Int
    var avatar: URL
}

extension User {
    static var mock: User {
        return User(
            name: "ChaselAn",
            projectCount: 6,
            starCount: 3,
            avatar: URL(string: "https://raw.githubusercontent.com/ChaselAn/iOSArchitecturesDemo/master/architecturesDemo/timg.jpeg")!
        )
    }
    
    static var guest: User {
        return User(
            name: "游客",
            projectCount: 0,
            starCount: 0,
            avatar: URL(string: "https://raw.githubusercontent.com/ChaselAn/iOSArchitecturesDemo/master/architecturesDemo/timg.jpeg")!
        )
    }
}
