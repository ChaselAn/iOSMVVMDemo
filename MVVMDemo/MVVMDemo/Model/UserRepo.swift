//
//  UserRepo.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation
import RxSwift
import RxCocoa

class UserRepo {
    
    var userOb: Observable<User> {
        return userRelay.distinctUntilChanged().asObservable()
    }
    var user: User {
        return userRelay.value
    }
    var starCount: Int {
        return userRelay.value.starCount
    }
    var projectCount: Int {
        return userRelay.value.projectCount
    }
    
    private var userRelay = BehaviorRelay<User>(value: User.guest)
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.userRelay.accept(User.mock)
        }
    }
    
    func changeStarCount(_ starCount: Int) {
        var new = user
        new.starCount = starCount
        userRelay.accept(new)
    }
    
    func changeProjectCount(_ projectCount: Int) {
        var new = user
        new.projectCount = starCount
        userRelay.accept(new)
    }
}
