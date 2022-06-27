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

    var wordleState: [WordleState] = [] {
        didSet {
            updateWordleState()
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
    private final func setupStackView() {
        axis = .vertical
        contentMode = .center
        spacing = defaultSpacing
        backgroundColor = .clear
        distribution = .fillEqually
    }

    private final func addWordleInputs() {
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

    private final func setupUI() {
        setupStackView()
        addWordleInputs()
    }

    private final func activeWordleInputView(_ index: Int = 0) {
        wordleInputViewCollection[index].active = true
    }

    private final func updateWordleState() {
        wordleInputViewCollection[currentActiveInputView].wordleState = wordleState
    }

    /// MARK: Public functions
    final func getInputWord() -> String {
        return wordleInputViewCollection[currentActiveInputView].getInputWord()
    }
}
