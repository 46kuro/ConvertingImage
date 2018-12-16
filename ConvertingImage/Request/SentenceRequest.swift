//
//  SentenceRequest.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import Foundation
import APIKit

final class SentenceRequest: Request {
    
    typealias Response = SentenceConvertingModel
    
    var baseURL: URL {
        // baseURLはCommitしないため、使用する際にPathを記述する
        return URL(string: "")!
    }
    
    var path: String {
        return "hackday_api/image-search"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String : Any]? {
        var params = [String : Any]()
        params["word"] = sentence
        params["tag"] = tag
        return params
    }
    
    let sentence: String
    let tag: String
    
    init(sentence: String, tag: String) {
        self.sentence = sentence
        self.tag = tag
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> SentenceConvertingModel {
        guard let data = object as? [String: String],
            let imageUrl = data["image-url"] else {
                return SentenceConvertingModel(imageUrlString: nil)
        }
        let model = SentenceConvertingModel(imageUrlString: imageUrl)
        return model
    }
}
