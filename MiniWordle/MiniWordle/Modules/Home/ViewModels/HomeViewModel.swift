//
//  HomeViewModel.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import Foundation

struct HomeViewModel {

    /// MARK: Properties
    private var numberOfLines = 6

    var numberOfMultiWorldInputViews: Int {
        return numberOfLines
    }

    private var numberOfFields = 5

    var numberOfWordleFields: Int {
        return numberOfFields
    }

    private var currentInputView = 0

    var currentActiveWordleInputView: Int {
        return currentInputView
    }

    var updateActiveWordleInputViewHandler: ((Int) -> ())?

    var updateWordleStateHandler: (([WordleState]) -> ())?

    /// MARK: Public functions
    mutating func moveToNextActiveWordleInputView(_ currentInputWord: String) {
        if currentInputWord.isEmpty || currentInputWord.count < numberOfWordleFields {
            return
        }

        print("Wordle \(currentInputWord)")

        currentInputView += 1

        if currentInputView >= numberOfLines {
            return
        }

        updateWordleState()
        updateActiveWordleInputViewHandler?(currentInputView)
    }

    private func updateWordleState() {
        updateWordleStateHandler?([.correct, .absent, .present, .correct, .absent])
    }
}
