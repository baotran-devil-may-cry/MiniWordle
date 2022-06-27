//
//  Enum.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Foundation
import UIKit

enum WordleState: Decodable {
    case absent, present, correct, error

    func rawColor() -> UIColor {
        switch self {
        case .absent:
            return UIColor(rgb: 0x807f89)
        case .present:
            return UIColor(rgb: 0xf4cd47)
        case .correct:
            return UIColor(rgb: 0xaad275)
        case .error:
            return UIColor.red
        }
    }

    init(from decoder: Decoder) throws {
        let state = try decoder.singleValueContainer().decode(String.self)
        switch state {
        case "absent":
            self = .absent
        case "present":
            self = .present
        default:
            self = .correct
        }
    }
}

enum LoadingState {
    case loading, normal
}

enum GameState {
    case win, lose
}
