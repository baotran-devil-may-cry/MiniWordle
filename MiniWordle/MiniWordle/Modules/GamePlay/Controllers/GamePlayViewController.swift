//
//  GamePlayViewController.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import Foundation
import UIKit

class GamePlayViewController: UIViewController {

    /// MARK: UI Properties

    /// MARK: Properties
    private lazy var viewModel: GamePlayViewModel = {
        return GamePlayViewModel()
    }()

    /// MARK: System functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// MARK: Private functions
    private func setupUI() {
        view.backgroundColor = .white
    }

}
