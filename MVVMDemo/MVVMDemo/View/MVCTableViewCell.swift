//
//  MVCTableViewCell.swift
//  architecturesDemo
//
//  Created by ac on 2019/1/19.
//  Copyright © 2019年 ac. All rights reserved.
//

import UIKit
import RxSwift

class MVCTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var starImageView: UIImageView!
    
    static var reuseIdentifier: String {
        return "MVCTableViewCell"
    }
    
    var rxData: Binder<(title: String, icon: UIImage?)> {
        return Binder<(title: String, icon: UIImage?)>.init(self) { (view, data) in
            view.setData(title: data.title, icon: data.icon)
        }
    }

    var imageViewTapAction: (()-> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        starImageView.isUserInteractionEnabled = true
        starImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(starImageViewDidTap)))
    }

    func setData(title: String, icon: UIImage?) {
        titleLabel.text = title
        starImageView.image = icon
    }

    @objc private func starImageViewDidTap(_ sender: UITapGestureRecognizer) {
        imageViewTapAction?()
    }
}
