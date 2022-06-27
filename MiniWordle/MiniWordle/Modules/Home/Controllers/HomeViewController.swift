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

        button.layer.cornerRadius = 25.asDesigned
        button.backgroundColor = UIColor(rgb: 0x73A3F0)
        button.setTitleColor(.white,
                             for: .normal)
        button.setTitle("SUBMIT",
                        for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)

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
        view.backgroundColor = UIColor(rgb: 0xF0ECE3)

        view.addSubview(multiWordleInputView)
        view.addSubview(enterWordButton)

        multiWordleInputView.numberOfWordleFields = viewModel.numberOfWordleFields
        multiWordleInputView.numberOfLines = viewModel.numberOfMultiWorldInputViews

        let margin8 = 8.asDesigned

        multiWordleInputView.snp.makeConstraints { make in
            let horizontalMargin20 = 20.asDesigned
            let layoutGuide = view.safeAreaLayoutGuide

            make.top
                .equalTo(layoutGuide.snp.top)
                .offset(margin8)
            make.left
                .equalTo(view.snp.left)
                .offset(horizontalMargin20)
            make.right
                .equalTo(view.snp.right)
                .offset(-horizontalMargin20)
        }

        enterWordButton.snp.makeConstraints { make in
            make.height.equalTo(50.asDesigned)
            make.width.equalTo(200.asDesigned)
            make.centerX.equalTo(multiWordleInputView.snp.centerX)
            make.top
                .equalTo(multiWordleInputView.snp.bottom)
                .offset(margin8)
        }
    }

    private final func enterWord() {
        viewModel.checkWordDefinition(multiWordleInputView.getInputWord())
    }

    private final func observeUIState() {
        viewModel.updateWordleStateHandler = {[weak self] wordleState in
            self?.multiWordleInputView.wordleState = wordleState
        }

        viewModel.updateNextActiveWordleInputViewHandler = { [weak self] nextIndex in
            self?.multiWordleInputView.currentActiveInputView = nextIndex
        }

        viewModel.updateLoadingState = { [weak self] state, title in
            self?.enterWordButton.setTitle(title,
                                           for: .normal)

            self?.enterWordButton.isUserInteractionEnabled = state == .normal
        }

        viewModel.updateGameState = { [weak self] message in
            let okAction = UIAlertAction(title: "Okay",
                                           style: .default) { [weak self] _ in
                self?.multiWordleInputView.resetGameState()
            }

            self?.showAlert(self,
                            title: "",
                            message: message,
                            actions: [okAction])
        }
    }

}
