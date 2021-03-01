//
//  MVCTableViewHeaderView.swift
//  architecturesDemo
//
//  Created by ac on 2019/1/19.
//  Copyright © 2019年 ac. All rights reserved.
//

import UIKit
import RxSwift

class MVCTableViewHeaderView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var rxData: Binder<(url: URL, nickname: String, leftText: String, rightText: String)> {
        return .init(self) { view, data in
            view.setData(url: data.url, nickname: data.nickname, leftText: data.leftText, rightText: data.rightText)
        }
    }
    
    func setData(url: URL, nickname: String, leftText: String, rightText: String) {
        nicknameTextField.text = nickname
        guard let data = try? Data(contentsOf: url) else { return }
        avatarImageView.image = UIImage(data: data)
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
}
