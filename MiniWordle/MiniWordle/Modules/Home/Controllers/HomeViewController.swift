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

    private lazy var enterWordButton: UIButton = {
        let button = UIButton(primaryAction: UIAction { [weak self] _ in
            self?.enterWord()
        })

        let padding24 = 24.asDesigned

        button.layer.cornerRadius = 25.asDesigned
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Enter word", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0,
                                                left: padding24,
                                                bottom: 0,
                                                right: padding24)

        return button
    }()

    /// MARK: Properties
    private lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()

    /// MARK: System functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        observeUIState()
    }

    /// MARK: Private functions
    private final func setupUI() {
        view.backgroundColor = .orange

        view.addSubview(multiWordleInputView)
        view.addSubview(enterWordButton)

        multiWordleInputView.numberOfWordleFields = viewModel.numberOfWordleFields
        multiWordleInputView.numberOfLines = viewModel.numberOfMultiWorldInputViews
        multiWordleInputView.currentActiveInputView = viewModel.currentActiveWordleInputView

        multiWordleInputView.snp.makeConstraints { make in
            let horizontalMargin20 = 20.asDesigned
            let layoutGuide = view.safeAreaLayoutGuide

            make.top.equalTo(layoutGuide.snp.top)
            make.left.equalTo(view.snp.left).offset(horizontalMargin20)
            make.right.equalTo(view.snp.right).offset(-horizontalMargin20)
        }

        enterWordButton.snp.makeConstraints { make in
            make.height.equalTo(50.asDesigned)
            make.top.equalTo(multiWordleInputView.snp.bottom).offset(20.asDesigned)
            make.centerX.equalTo(multiWordleInputView.snp.centerX)
        }
    }

    private final func enterWord() {
        viewModel.moveToNextActiveWordleInputView(multiWordleInputView.getInputWord())
    }

    private final func observeUIState() {
        viewModel.updateWordleStateHandler = {[weak self] wordleState in
            self?.multiWordleInputView.wordleState = wordleState
        }

        viewModel.updateActiveWordleInputViewHandler = { [weak self] nextInputView in
            self?.multiWordleInputView.currentActiveInputView = nextInputView
        }
    }

}
