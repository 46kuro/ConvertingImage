//
//  SentenceMorphologicalAnalysisTests.swift
//  ConvertingImageTests
//
//  Created by 齋藤健悟 on 2018/12/16.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//
import Foundation
import XCTest
@testable import ConvertingImage
class SentenceMorphologicalAnalysisTests: XCTestCase {
    func testMorphologicalAnalysis_1() {
        let text = "I have a pen"
        let result = SentenceMorphologicalAnalysis.morphologicalAnalysis(text: text)
        
        XCTAssertEqual(result[0].word, "I")
        XCTAssertEqual(result[1].word, "have")
        XCTAssertEqual(result[2].word, "a")
        XCTAssertEqual(result[3].word, "pen")
        
        XCTAssertEqual(result[0].tag, .image)
        XCTAssertEqual(result[1].tag, .image)
        XCTAssertEqual(result[2].tag, .other)
        XCTAssertEqual(result[3].tag, .image)
    }
    
    func testMorphologicalAnalysis_2() {
        let text = "It is very big pig"
        let result = SentenceMorphologicalAnalysis.morphologicalAnalysis(text: text)
        
        XCTAssertEqual(result[0].word, "It")
        XCTAssertEqual(result[1].word, "is")
        XCTAssertEqual(result[2].word, "very")
        XCTAssertEqual(result[3].word, "big")
        XCTAssertEqual(result[4].word, "pig")
        
        XCTAssertEqual(result[0].tag, .image)
        XCTAssertEqual(result[1].tag, .image)
        XCTAssertEqual(result[2].tag, .other)
        XCTAssertEqual(result[3].tag, .image)
        XCTAssertEqual(result[4].tag, .image)
    }
}
