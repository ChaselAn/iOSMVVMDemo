//
//  HeaderViewContainer.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import Foundation
import RxSwift

protocol HeaderViewContainerData {
    var nameOb: Observable<String> { get }
    var leftTextOb: Observable<String> { get }
    var rightTextOb: Observable<String> { get }
    var avatarOb: Observable<UIImage?> { get }
}

class HeaderViewContainer {
    
    let view = Bundle.main.loadNibNamed("MVCTableViewHeaderView", owner: nil, options: nil)!.first as! MVCTableViewHeaderView
    
    private let disposeBag = DisposeBag()

    init(data: HeaderViewContainerData) {
        data.nameOb.bind(to: view.nicknameTextField.rx.text).disposed(by: disposeBag)
        data.leftTextOb.bind(to: view.leftLabel.rx.text).disposed(by: disposeBag)
    }
}
