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

    var numberOfWordleFields = 5 {
        didSet {
            addWordleInputs()
        }
    }

    var currentActiveInputView = 0 {
        didSet {
            activeWordleInputView(currentActiveInputView)
        }
    }

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
            wordleInputView.numberOfWordleFields = numberOfWordleFields
            addArrangedSubview(wordleInputView)
            wordleInputViewCollection.append(wordleInputView)
        }

        activeWordleInputView()
    }

    private func setupUI() {
        setupStackView()
        addWordleInputs()
    }

    private func activeWordleInputView(_ index: Int = 0) {
        wordleInputViewCollection[index].active = true
    }

    func getInputWord() -> String {
        return wordleInputViewCollection[currentActiveInputView].getInputWord()
    }
}
