//
//  UserInfoDataModel.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

struct UserInfoDataModel: Codable {
    let username, nickname: String
    
    enum CodingKeys: CodingKey {
        case username
        case nickname
    }
}
