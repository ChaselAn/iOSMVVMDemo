//
//  ViewModel.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation
import RxSwift

class ViewModel {
    
    var projectListOb: Observable<[Project]> {
        return projectRepo.projectListOb
    }
    
    var userName: Observable<String> {
        return userRepo.userOb.map({ $0.name })
    }
    
    var userIcon: Observable<UIImage?> {
        return userRepo.userOb.map({
            guard let data = try? Data(contentsOf: $0.avatar) else { return nil }
            return UIImage(data: data)
        })
    }
    
    var projectCountStrOb: Observable<String> {
        return userRepo.userOb.map({ "项目数：\($0.projectCount)" })
    }
    
    var starCountStrOb: Observable<String> {
        return userRepo.userOb.map({ "star数：\($0.starCount)" })
    }
    
    private let userRepo = UserRepo()
    private let projectRepo = ProjectRepo()
    
    func fetch() {
        userRepo.fetch()
        projectRepo.fetch()
    }
    
    func star(id: String) {
        projectRepo.star(id: id) { [weak self] (success) in
            guard success, let self = self else { return }
            self.userRepo.changeStarCount(self.userRepo.starCount + 1)
        }
    }
    
    func unStar(id: String) {
        projectRepo.unStar(id: id) { [weak self] (success) in
            guard success, let self = self else { return }
            self.userRepo.changeStarCount(max(self.userRepo.starCount - 1, 0))
        }
    }
}

