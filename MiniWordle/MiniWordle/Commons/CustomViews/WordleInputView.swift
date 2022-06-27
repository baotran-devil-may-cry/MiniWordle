//
//  WordleInputView.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import UIKit
import SnapKit

/// MARK: WordleTextField
final class WordleTextField: UITextField {

    /// MARK: UI Properties
    weak var previousTextField: WordleTextField?

    weak var nextTextField: WordleTextField?

    /// MARK: Override functions
    override func deleteBackward() {
        // Case 1: the user clicked on deleteBackward
        // If the current textfield has no text, we will back to previous textfield
        // then remove the text on previous textfield
        if let text = text, text.isEmpty, previousTextField != nil {
            previousTextField?.text = ""
            previousTextField?.becomeFirstResponder()
        }
        // Case 2: the user clicked on deleteBackward
        // If the current textfield has a text, we just need to clear the text
        else {
            text = ""
        }
    }

}

final class WordleInputView: UIStackView {

    /// MARK: Properties
    // Number of WordleTextField is 5 as default
    var numberOfWordleFields = 5 {
        didSet {
            addWordleFields()
        }
    }

    var defaultSpacing = 5.asDesigned {
        didSet {
            spacing = defaultSpacing
        }
    }

    var active: Bool = false {
        didSet {
            wordleTextFieldsCollection[0].becomeFirstResponder()
        }
    }

    var wordleState: [WordleState] = [] {
        didSet {
            updateWordleState()
        }
    }

    private(set) var wordleTextFieldsCollection: [WordleTextField] = []

    //Custom colors
    let activeBorderColor = UIColor.black

    let inactiveBorderColor = UIColor.white

    let textBackgroundColor = UIColor(rgb: 0xE9E7E1)

    /// MARK: System functions
    required init(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    /// MARK: Private functions
    private func setupUI() {
        setupStackView()
        addWordleFields()
    }

    private final func setupStackView() {
        contentMode = .center
        spacing = defaultSpacing
        backgroundColor = .clear
        distribution = .fillEqually
        isUserInteractionEnabled = false
    }

    private final func addWordleFields() {
        // Need to remove all of arranged subviews for rebuilding UI purposes
        if !wordleTextFieldsCollection.isEmpty {
            wordleTextFieldsCollection.removeAll()
            removeArrangedSubView()
        }

        for index in 0..<numberOfWordleFields {
            let field = WordleTextField()
            setupWordleTextField(field)
            wordleTextFieldsCollection.append(field)
            index != 0 ? (field.previousTextField = wordleTextFieldsCollection[index - 1]) : (field.previousTextField = nil)
            index != 0 ? (wordleTextFieldsCollection[index - 1].nextTextField = field) : ()
        }
    }

    private final func setupWordleTextField(_ wordleTextField: WordleTextField) {
        addArrangedSubview(wordleTextField)
        wordleTextField.delegate = self
        wordleTextField.textColor = .white
        wordleTextField.tintColor = .clear
        wordleTextField.backgroundColor = textBackgroundColor
        wordleTextField.textAlignment = .center
        wordleTextField.adjustsFontSizeToFitWidth = false
        wordleTextField.font = UIFont.systemFont(ofSize: 40.asDesigned)
        wordleTextField.layer.cornerRadius = 5.asDesigned
        wordleTextField.layer.borderWidth = 2.asDesigned
        wordleTextField.layer.borderColor = inactiveBorderColor.cgColor
        wordleTextField.keyboardType = .alphabet
        wordleTextField.autocorrectionType = .no
    }

    private final func updateWordleState() {
        if !wordleState.isEmpty {
            for (index, state) in wordleState.enumerated() {
                wordleTextFieldsCollection[index].backgroundColor = state.rawColor()
            }
        }
    }

    /// MARK: Public functions
    final func getInputWord() -> String {
        var word = ""
        for textField in wordleTextFieldsCollection {
            word += textField.text ?? ""
        }

        return word
    }
}

/// MARK: Extensions
extension WordleInputView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Avoid user input number, whitespace, newline
        // Just accept character only
        let characterSet = CharacterSet.letters

        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }

        guard let textField = textField as? WordleTextField else { return true }

        // If the editing textfield has no text
        if range.length == 0 {
            // If this textField is the last textField
            if textField.nextTextField == nil {
                if let currentText = textField.text, currentText.isEmpty {
                    textField.text = string.uppercased()
                } else {
                    textField.text = textField.text?.uppercased()
                }
            } else {
                // If still has a remaining nextTextfield
                textField.text = string.uppercased()
                textField.nextTextField?.becomeFirstResponder()
            }

            return false
        }

        return true
    }

}
