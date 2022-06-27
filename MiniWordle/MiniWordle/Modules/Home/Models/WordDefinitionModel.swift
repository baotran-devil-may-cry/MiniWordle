//
//  WordDefinitionResultModel.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Foundation

struct WordDefinitionModel: Decodable {
    let word: String
    let license: License
    let sourceUrls: [String]
}

struct License: Decodable {
    let name: String
    let url: String
}

