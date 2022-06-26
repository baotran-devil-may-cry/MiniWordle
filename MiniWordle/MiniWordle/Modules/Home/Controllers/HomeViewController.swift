//
//  HomeViewController.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    /// MARK: UI Properties
    private lazy var multiWordleInputView: MultiWordleInputView = {
        let inputView = MultiWordleInputView()

        return inputView
    }()

    /// MARK: Properties
    private lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()

    /// MARK: System functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    /// MARK: Private functions
    private func setupUI() {
        view.backgroundColor = .orange

        view.addSubview(multiWordleInputView)

        multiWordleInputView.snp.makeConstraints { make in
            let horizontalMargin20 = 20.asDesigned
            let layoutGuide = view.safeAreaLayoutGuide

            make.top.equalTo(layoutGuide.snp.top)
            make.left.equalTo(view.snp.left).offset(horizontalMargin20)
            make.right.equalTo(view.snp.right).offset(-horizontalMargin20)
        }
    }

}
