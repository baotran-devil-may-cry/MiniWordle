//
//  WordDefinitionModel.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import Foundation

struct WordDefinitionModel: Decodable {
    let title: String
    let message: String
    let resolution: String
}
