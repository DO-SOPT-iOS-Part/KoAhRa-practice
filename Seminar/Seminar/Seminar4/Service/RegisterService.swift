//
//  RegisterService.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

class RegisterService: BaseService {
    static let shared = RegisterService()
    
    private override init() {
        super.init()
    }
    
    func makeRequestBody(userName: String,
                         password: String,
                         nickName: String) -> Data? {
        do {
            let data = RegisterRequestBody(username: userName,
                                           password: password,
                                           nickname: nickName)
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    func makeRequest(body: Data?) -> URLRequest {
        let urlString = Config.baseURL + "/api/v1/members"
        return RegisterService.makePostRequest(urlString: urlString, body: body)
    }
    
    func PostRegisterData(userName: String, password: String, nickName: String) async throws -> Int {
        do {
            let urlString = Config.baseURL + "/api/v1/members"
            guard let body = makeRequestBody(userName: userName,
                                             password: password,
                                             nickName: nickName)
            else { throw NetworkError.requstEncodingError }
            return try await RegisterService.postData(urlString: urlString, body: body)
        } catch {
            throw error
        }
    }
}
