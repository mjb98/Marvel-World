//
//  URLSession+CustomPublisher.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import Foundation

extension URLSession {
    func publisher<T,R: Decodable>(
        for endpoint: Endpoint<T>,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<R, Error> {
        guard let request = endpoint.makeRequest() else {
            return Fail(
                error: NetworkError.InvalidEndpointError
            ).eraseToAnyPublisher()
        }

        return dataTaskPublisher(for: request)
            .timeout(10, scheduler: RunLoop.main, options: nil, customError: {
                return URLError(.timedOut)
            })
            .map(\.data)
            .decode(type: NetworkResponse<R>.self, decoder: decoder)
            .tryMap {
                guard let data = $0.data else {
                    throw NetworkError.customError(code: $0.code, message: $0.message)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}


extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}
