//
//  RegisterRequestBody.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

struct RegisterRequestBody: Codable {
    let username: String
    let password: String
    let nickname: String
}
