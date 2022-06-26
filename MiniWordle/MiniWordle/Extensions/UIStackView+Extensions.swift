//
//  UIStackView+Extensions.swift
//  MiniWordle
//
//  Created by TranQuocBao on 26/06/2022.
//

import UIKit

extension UIStackView {
    func removeArrangedSubView() {
        while let first = arrangedSubviews.first {
            removeArrangedSubview(first)
            first.removeFromSuperview()
        }
    }
}
