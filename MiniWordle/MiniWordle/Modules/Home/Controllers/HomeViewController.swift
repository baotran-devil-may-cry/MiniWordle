//
//  HomeViewController.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    /// MARK: UI Properties

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
        view.backgroundColor = .white
    }

}
