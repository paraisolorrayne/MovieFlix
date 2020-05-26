//
//  HttpClientMock.swift
//  MovieFlixTests
//
//  Created by Judar Lima on 23/07/19.
//  Copyright © 2019 Judar Lima. All rights reserved.
//

import XCTest
@testable import MovieFlix

class ClientMock: ClientProtocol {
    var isFailure = false

    func requestData<T : Decodable>(with setup: ClientSetup, completion: @escaping (Result<T>) -> Void) {
        if isFailure {
            completion(.failure(ClientError.invalidHttpResponse))
            return
        } else {
            completion(generateData())
        }
    }

    private func generateData<T: Decodable>() -> Result<T> {
        guard
            let filePath = Bundle.main.path(forResource: "upcoming", ofType: "json")
            else {
                XCTFail("Could not mock data!")
                return .failure(ClientError.brokenData)
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath),
                                    options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(T.self, from: jsonData)
            return .success(responseModel)
        } catch { }
        return .failure(ClientError.brokenData)
    }
}
