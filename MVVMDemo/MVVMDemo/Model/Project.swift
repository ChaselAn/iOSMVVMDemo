//
//  Project.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation

struct ProjectList: Codable {
    var list: [Project]
}

struct Project: Codable, Equatable {
    var id: String
    var title: String
    var isStar: Bool

    init(title: String, isStar: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isStar = isStar
    }
}

extension ProjectList {
    static var mock: ProjectList {
        
        return ProjectList(list: [
            Project(title: "Dinergate", isStar: true),
            Project(title: "UILayoutSugar", isStar: false),
            Project(title: "SoapBubble", isStar: true),
            Project(title: "MonkeyKing", isStar: true),
            Project(title: "ACTagView", isStar: false),
            Project(title: "FancyAlert", isStar: false)
        ])
    }
}
