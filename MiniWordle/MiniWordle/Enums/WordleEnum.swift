//
//  Enum.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Foundation
import UIKit

enum WordleState {
    case absent, present, correct

    func rawColor() -> UIColor {
        switch self {
        case .absent:
            return .darkGray
        case .present:
            return .yellow
        case .correct:
            return .green
        }
    }
}
