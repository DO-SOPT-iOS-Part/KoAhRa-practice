//
//  ImageCollectionData.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/28.
//

import Foundation

struct ImageCollectionData {
    let image: String
    var isLiked: Bool
    
    init(image: String, isLiked: Bool) {
        self.image = image
        self.isLiked = isLiked
    }
}
