//
//  SentenceConvertingPresenter.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import Foundation
import APIKit

/// 通信してモデルを返却する
final class SentenceConvertingPresenter {
    let requestSucceededHandler: ((SentenceConvertingModel) -> Void)
    let requestFailedHandler: ((Error) -> Void)
    
    init(requestSucceededHandler: @escaping ((SentenceConvertingModel) -> Void),
         requestFailedHandler: @escaping ((Error) -> Void)) {
        self.requestSucceededHandler = requestSucceededHandler
        self.requestFailedHandler = requestFailedHandler
    }
    
    func request(sentence: String, tag: NSLinguisticTag) {
        let tagParam: String
        switch tag {
        case .verb:
            tagParam = "verb"
        default:
            tagParam = ""
        }
        let request = SentenceRequest(sentence: sentence, tag: tagParam)
        Session.send(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.requestSucceededHandler(response)
            case .failure(let error):
                self.requestFailedHandler(error)
            }
        }
    }
}
