//
//  SentenceConvertingModel.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import Foundation

struct SentenceConvertingModel: Codable {
    let imageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrlString = "image-url"
    }
}
