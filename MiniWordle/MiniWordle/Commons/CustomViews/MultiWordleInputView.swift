//
//  MultiWordleInputView.swift
//  MiniWordle
//
//  Created by TranQuocBao on 26/06/2022.
//

import UIKit
import SnapKit

class MultiWordleInputView: UIStackView {

    /// MARK: Properties
    var numberOfLines = 6 {
        didSet {
            addWordleInputs()
        }
    }

    var currentActiveInputView = 0

    var defaultSpacing = 5.asDesigned {
        didSet {
            spacing = defaultSpacing
        }
    }

    private(set) var wordleInputViewCollection: [WordleInputView] = []

    /// MARK: System functions
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    /// MARK: Private functions
    private func setupStackView() {
        axis = .vertical
        contentMode = .center
        spacing = defaultSpacing
        backgroundColor = .clear
        distribution = .fillEqually
    }

    private func addWordleInputs() {
        if !wordleInputViewCollection.isEmpty {
            wordleInputViewCollection.removeAll()
            removeArrangedSubView()
        }

        for _ in 0..<numberOfLines {
            let wordleInputView = WordleInputView()
            addArrangedSubview(wordleInputView)
            wordleInputViewCollection.append(wordleInputView)
        }
    }

    private func setupUI() {
        setupStackView()
        addWordleInputs()
    }
}
