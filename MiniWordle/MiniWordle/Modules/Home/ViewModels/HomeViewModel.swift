//
//  HomeViewModel.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import Foundation

final class HomeViewModel {

    /// MARK: Properties
    private var numberOfLines = 6

    var numberOfMultiWorldInputViews: Int {
        return numberOfLines
    }

    private var numberOfFields = 5

    var numberOfWordleFields: Int {
        return numberOfFields
    }

    var updateNextActiveWordleInputViewHandler: ((Int) -> ())?

    var updateWordleStateHandler: (([WordleState], String?) -> ())?

    var updateLoadingState: ((LoadingState, String) -> ())?

    var updateGameState: ((String) -> ())?

    private let buttonLoadingStateTitle = "LOADING"

    private let buttonNormalStateTitle = "SUBMIT"

    private var currentActiveWordleInputView = 0

    /// MARK: Public functions
    final func checkWordDefinition(_ currentInputWord: String) {
        if currentInputWord.isEmpty || currentInputWord.count < numberOfWordleFields {
            return
        }

        updateRequestState(.loading)

        NetworkManager.shared.checkWordDefinition(guess: currentInputWord) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.checkInputGuessWord(currentInputWord)
            case .failure:
                self.updateRequestState(.normal)
                self.updateWordleStateHandler?(self.generateErrorState(), "You can't use this word: \(currentInputWord)")
            }
        }
    }

    /// MARK: Private functions
    private final func checkInputGuessWord(_ word: String) {
        NetworkManager.shared.guessRandomWord(guess: word, seed: 1234) { [weak self] result in
            self?.updateRequestState(.normal)

            switch result {
            case .success(let wordleResultModel):
                let wordleState = wordleResultModel.map { return $0.result }
                self?.checkGameState(wordleState, word)
                self?.updateWordleState(wordleState)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private final func updateWordleState(_ wordleState: [WordleState]) {
        updateWordleStateHandler?(wordleState, nil)
        updateNextActiveWordleInputViewHandler?(currentActiveWordleInputView)
    }

    private final func updateCurrentActiveWordleInputView() {
        if currentActiveWordleInputView < numberOfLines - 1 {
            currentActiveWordleInputView += 1
        }
    }

    private final func updateRequestState(_ state: LoadingState) {
        if state == .loading {
            updateLoadingState?(.loading, buttonLoadingStateTitle)
        } else if state == .normal {
            updateLoadingState?(.normal, buttonNormalStateTitle)
        }
    }

    private final func generateErrorState() -> [WordleState] {
        return Array(repeating: WordleState.error, count: numberOfFields)
    }

    private final func checkGameState(_ wordleState: [WordleState],
                                      _ word: String) {
        let isAllCorrect = wordleState.allSatisfy { $0 == .correct }

        if isAllCorrect {
            clearData()
            updateGameState?("You win!!!. The secret word is: \(word)")
        } else {
            if currentActiveWordleInputView + 1 == numberOfLines {
                clearData()
                updateGameState?("Game over. Please try again!!!")
            } else {
                updateCurrentActiveWordleInputView()
            }
        }
    }

    private final func clearData() {
        currentActiveWordleInputView = 0
    }
}
