//
//  ProjectRepo.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation
import RxCocoa
import RxSwift

class ProjectRepo {
    
    var projectListOb: Observable<[Project]> {
        return projectListRelay.distinctUntilChanged().asObservable()
    }
    var projectList: [Project] {
        return projectListRelay.value
    }
    private var projectListRelay = BehaviorRelay<[Project]>(value: [])
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.projectListRelay.accept(ProjectList.mock.list)
        }
    }
    
    func star(id: String, completion: @escaping (Bool) -> Void) {
        guard let project = projectList.first(where: { $0.id == id }), !project.isStar else {
            completion(false)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let index = self.projectList.firstIndex(where: { $0.id == id }) else {
                completion(false)
                return
            }
            var new = self.projectList
            var newP = new[index]
            newP.isStar = true
            new[index] = newP
            self.projectListRelay.accept(new)
            completion(true)
        }
    }
    
    func unStar(id: String, completion: @escaping (Bool) -> Void) {
        guard let project = projectList.first(where: { $0.id == id }), project.isStar else {
            completion(false)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let index = self.projectList.firstIndex(where: { $0.id == id }) else {
                completion(false)
                return
            }
            var new = self.projectList
            var newP = new[index]
            newP.isStar = false
            new[index] = newP
            self.projectListRelay.accept(new)
            completion(true)
        }
    }
}
