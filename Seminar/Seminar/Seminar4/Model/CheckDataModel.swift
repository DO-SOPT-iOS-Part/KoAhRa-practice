//
//  CheckDataModel.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import Foundation

struct CheckDataModel: Codable {
    
    let isExist: Bool
    
    enum CodingKeys: CodingKey {
        case isExist
    }
}
