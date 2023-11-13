//
//  BaseService.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/13.
//

import Foundation

class BaseService {
    static func makeRequest(urlString: String, method: String, body: Data?) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        if let body = body {
            request.httpBody = body
        }
        return request
    }

    static func makeGetRequest(urlString: String) -> URLRequest {
        return makeRequest(urlString: urlString, method: "GET", body: nil)
    }

    static func makePostRequest(urlString: String, body: Data?) -> URLRequest {
        return makeRequest(urlString: urlString, method: "POST", body: body)
    }

    static func parseData<T: Decodable>(data: Data, modelType: T.Type) -> T? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(modelType, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    static func postData(urlString: String, body: Data?) async throws -> Int {
        do {
            let request = makePostRequest(urlString: urlString, body: body)
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            return httpResponse.statusCode
        } catch {
            throw error
        }
    }
    
    static func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode) ?? NetworkError.unknownError
    }
}
