//
//  ViewController.swift
//  MVVMDemo
//
//  Created by ancheng on 2021/3/1.
//

import UIKit
import UILayoutSugar
import RxSwift

class ViewController: UIViewController {

    private let tableView = UITableView()
    private var headerView = Bundle.main.loadNibNamed("MVCTableViewHeaderView", owner: nil, options: nil)!.first as! MVCTableViewHeaderView

    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        config()
        bindUI()
        viewModel.fetch()
    }

    private func makeUI() {
        view.addSubview(headerView)
        headerView <> [.leading, .trailing, .top]
        
        view.addSubview(tableView)
        tableView <> [.leading, .trailing, .bottom]
        tableView.topAnchor <> headerView.bottomAnchor
    }

    private func config() {
        tableView.register(UINib(nibName: "MVCTableViewCell", bundle: nil), forCellReuseIdentifier: MVCTableViewCell.reuseIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addRepo))
    }
    
    private func bindUI() {
        viewModel.userName.bind(to: headerView.nicknameTextField.rx.text).disposed(by: disposeBag)
        viewModel.userIcon.bind(to: headerView.avatarImageView.rx.image).disposed(by: disposeBag)
        viewModel.projectCountStrOb.bind(to: headerView.leftLabel.rx.text).disposed(by: disposeBag)
        viewModel.starCountStrOb.bind(to: headerView.rightLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.projectListOb.bind(to: tableView.rx.items(cellIdentifier: MVCTableViewCell.reuseIdentifier, cellType: MVCTableViewCell.self)) { [weak self] index, model, cell in
            cell.setData(title: model.title, icon: model.isStar ? #imageLiteral(resourceName: "icon_star") : #imageLiteral(resourceName: "icon_unstar"))
            cell.selectionStyle = .none
            cell.imageViewTapAction = { [weak self] in
                guard let self = self else { return }
                model.isStar ? self.viewModel.unStar(id: model.id) : self.viewModel.star(id: model.id)
            }
        }.disposed(by: disposeBag)
    }

    @objc private func addRepo() {
//        let alert = UIAlertController(title: "add repo", message: nil, preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak self] (_) in
//            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
//            self?.viewModel.addProject(title: text)
//        }))
//        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
}
