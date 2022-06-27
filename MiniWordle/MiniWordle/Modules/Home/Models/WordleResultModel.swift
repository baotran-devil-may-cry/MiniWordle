//
//  WordleResultModel.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Foundation

struct WordleResultModel: Decodable {
    let slot: Int
    let guess: String
    let result: WordleState
}
