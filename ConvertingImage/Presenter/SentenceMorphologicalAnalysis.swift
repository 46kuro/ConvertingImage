//
//  SentenceMorphologicalAnalysis.swift
//  ConvertingImage
//
//  Created by 齋藤健悟 on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import Foundation

/// イメージにできるか
///
/// - image: イメージできる
/// - other: できない
enum ImageOrOther {
    case image
    case other
}

struct MorphologicalAnalysisResult {
    let word: String
    let tag: ImageOrOther
}

final class SentenceMorphologicalAnalysis {
    
    /// 形態素解析で品詞を分析する
    /// https://qiita.com/thimi0412/items/8a47daaac154c01647ccsを参考にした
    ///
    /// - Parameter text: テキスト
    static func morphologicalAnalysis(text: String) -> [MorphologicalAnalysisResult] {
        // en: 英語
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)
        
        tagger.string = text
        
        var resultList = [MorphologicalAnalysisResult]()
        tagger.enumerateTags(in: NSRange(location: 0, length: text.count),
                             scheme: NSLinguisticTagScheme.lexicalClass,
                             options: [.omitWhitespace]) { tag, tokenRange, sentenceRange, stop in
                                
                                let subString = (text as NSString).substring(with: tokenRange)
                                print("\(subString) : \(String(describing: tag!.rawValue))")
                                
                                let sentenceTag = makeSentenceLinguisticTag(from: tag!)
                                let result = MorphologicalAnalysisResult(word: subString, tag: sentenceTag)
                                resultList.append(result)
        }
        return resultList
    }
    
    /// 入力されたタグからイメージにできるかを返します
    ///
    /// - Parameter tag: 形態素解析した結果のタグ
    /// - Returns: イメージにできるか
    private static func makeSentenceLinguisticTag(from tag: NSLinguisticTag) -> ImageOrOther {
        switch tag {
        case NSLinguisticTag.noun:
            return .image
        case NSLinguisticTag.verb:
            return .image
        case NSLinguisticTag.pronoun:
            return .image
        case NSLinguisticTag.adjective:
            return .image
        default:
            return .other
        }
    }
}
