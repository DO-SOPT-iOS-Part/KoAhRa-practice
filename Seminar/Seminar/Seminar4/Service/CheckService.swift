//
//  CheckService.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

class CheckService {
    static let shared = CheckService()
    private init() {}
    
    func makeCheckRequest(username: String) -> URLRequest {
        let url = URL(string: "http://3.39.54.196/api/v1/members/check?username=\(username)")!
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func PostCheck(username: String) async throws -> CheckDataModel? {
        do {
            let request = self.makeCheckRequest(username: username)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            return parseCheckData(data: data)
        } catch {
            throw error
        }
        
    }
    
    private func parseCheckData(data: Data) -> CheckDataModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(CheckDataModel.self, from: data)
            print(result)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}
