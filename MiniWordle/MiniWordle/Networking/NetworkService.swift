//
//  NetworkService.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Moya

public enum NetworkService {
    case guessRandomWord(guess: String, seed: Int)
    case checkWordDefinition(guess: String,
                             language: String)
}

extension NetworkService: TargetType {

    public var baseURL: URL {
        var url: URL?

        switch self {
        case .guessRandomWord:
            url = URL(string: "https://v1.wordle.k2bd.dev")
        case .checkWordDefinition:
            url = URL(string: "https://api.dictionaryapi.dev/api/v2")
        }

        guard let url = url else { fatalError() }

        return url
    }

    public var path: String {
        switch self {
        case .guessRandomWord:
            return "/random"
        case .checkWordDefinition(let guess, let language):
            return "/entries/\(language)/\(guess)"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .guessRandomWord(let guess, let seed):
            return .requestParameters(
                parameters: [
                    "guess": guess,
                    "seed": seed
                ],
                encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
        ]
    }

    public var validationType: ValidationType {
        return .successCodes
    }

}
