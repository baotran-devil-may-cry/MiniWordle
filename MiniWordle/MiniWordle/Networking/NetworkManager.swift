//
//  NetworkManager.swift
//  MiniWordle
//
//  Created by TranQuocBao on 27/06/2022.
//

import Moya

final class NetworkManager {

    /// MARK: Constructor
    private init() {
        // Customize Provider for logger, loading state
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure = {(activity, _) in
            switch activity {
            case .began:
                print("Start Loading")
            case .ended:
                print("End Loading")
            }
        }

        var plugins: [PluginType] = []

        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        plugins.append(networkActivityPlugin)

        let networkLogger = NetworkLoggerPlugin(configuration: .init(formatter: .init(), output: { target, array in
            if let log = array.first {
                print("MiniWordle API Service: \(log)")
            }
        }, logOptions: .formatRequestAscURL))
        plugins.append(networkLogger)

        provider = MoyaProvider<NetworkService>(plugins: plugins)

        /// Set time out for request
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 10
    }

    /// MARK: Public properties
    static let shared = NetworkManager()

    private let provider: MoyaProvider<NetworkService>

}

/// MARK: Extension
extension NetworkManager {

    func request<T: Decodable>(target: NetworkService,
                               completion: @escaping (Result<T, Error>) -> (),
                               isShowIndicator: Bool = false) {
        if (isShowIndicator) {
            // Use to show Loading Indicator if needed
        }

        provider.request(target) { result in
            if (isShowIndicator) {
                // Use to hide Loading Indicator after api completed successfully
            }
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
