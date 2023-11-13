//
//  GetInfoService.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

class GetInfoService: BaseService{
    static let shared = GetInfoService()
    
    private override init() {
        super.init()
    }
    
    func makeRequest(userId: Int) -> URLRequest {
        let urlString = "http://3.39.54.196/api/v1/members/\(userId)"
        return GetInfoService.makeGetRequest(urlString: urlString)
    }
    
    func PostRegisterData(userId: Int) async throws -> UserInfoDataModel? {
        do {
            let request = self.makeRequest(userId: userId)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else {
                throw NetworkError.responseError
            }
            return GetInfoService.parseData(data: data, modelType: UserInfoDataModel.self)
        } catch {
            throw error
        }
    }
}
