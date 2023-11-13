//
//  CheckService.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

class CheckService: BaseService {
    static let shared = CheckService()
    
    private override init() {
        super.init()
    }
    
    func makeRequest(username: String) -> URLRequest {
        let urlString = "http://3.39.54.196/api/v1/members/check?username=\(username)"
        return GetInfoService.makeGetRequest(urlString: urlString)
    }
    
    func PostCheck(username: String) async throws -> CheckDataModel? {
        do {
            let request = self.makeRequest(username: username)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else {
                throw NetworkError.responseError
            }
            return CheckService.parseData(data: data, modelType: CheckDataModel.self)
        } catch {
            throw error
        }
    }
}
