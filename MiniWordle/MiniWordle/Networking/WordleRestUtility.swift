//
//  WordleApiService.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Moya

extension NetworkManager {
    final func guessRandomWord(guess: String, seed: Int,
                         completion: @escaping (Result<[WordleResultModel], Error>) -> ()) {
        request(target: .guessRandomWord(guess: guess,
                                         seed: seed),
                completion: completion)
    }

    final func checkWordDefinition(guess: String,
                             language: String = "en",
                             completion: @escaping (Result<[WordDefinitionModel], Error>) -> ()) {
        request(target: .checkWordDefinition(guess: guess, language: language),
                completion: completion)
    }
}
