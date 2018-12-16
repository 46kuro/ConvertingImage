//
//  SentenceConvertingViewController.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import UIKit

class SentenceConvertingViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var textImageCollectionView: UICollectionView!
    
    var sentence: String?
    var results: [MorphologicalAnalysisResult]?
    
    var listCount: Int {
        return results?.filter({ $0.tag == .image }).count ?? 0
    }
    
    static func instantiate(sentence: String) -> SentenceConvertingViewController {
        let viewController = SentenceConvertingViewController.instantiate()
        viewController.sentence = sentence
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "文章表示"
        
        if let sentence = sentence {
            results = SentenceMorphologicalAnalysis.morphologicalAnalysis(text: sentence)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 3.0
        flowLayout.itemSize = CGSize(width: 140.0, height: 260)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.scrollDirection = .horizontal
        // Self-Sizingの有効化
        textImageCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        textImageCollectionView.dataSource = self
        textImageCollectionView.register(cellType: SentenceConvertingCollectionViewCell.self)
    }
    
    /// IndexPath.row未満の.otherを全て抜いたresult
    func results(indexPath: IndexPath) -> [MorphologicalAnalysisResult]? {
        guard results?.count ?? 0 > indexPath.row else { return nil }
        return results?.enumerated().compactMap({
            if $0.offset < indexPath.row && $0.element.tag == .other { return nil }
            return $0.element
        })
    }
    
}

extension SentenceConvertingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SentenceConvertingCollectionViewCell.self)
        guard let trimmedResults = results(indexPath: indexPath),
            trimmedResults.count > indexPath.row else {
                return cell
        }
        let result = trimmedResults[indexPath.row]
        
        // 画像データ取得
        let requestSucceededHandler = { (model: SentenceConvertingModel) in
            guard let urlString = model.imageUrlString,
                let url = URL(string: urlString),
                let imageData = try? Data(contentsOf: url) else {
                    cell.indicatorView.stopAnimating()
                    cell.indicatorView.isHidden = true
                    return
            }
            
            cell.imageView.image = UIImage(data: imageData)
            cell.indicatorView.stopAnimating()
            cell.indicatorView.isHidden = true
            
        }
        let requestFailedHandler = { (error: Error) in
            return
        }
        cell.presenter = SentenceConvertingPresenter(requestSucceededHandler: requestSucceededHandler,
                                                     requestFailedHandler: requestFailedHandler)
        
        // 文字列データを取得
        let name: String
        let name2: String?
        if result.tag == .other {
            guard trimmedResults.count + 1 > indexPath.row else { return cell }
            let nextWord = trimmedResults[indexPath.row + 1].word
            name = result.word
            name2 = nextWord
            cell.presenter?.request(sentence: nextWord, tag: result.linguisticTag)
        } else {
            name = result.word
            name2 = nil
            
            cell.presenter?.request(sentence: name, tag: result.linguisticTag)
        }
        cell.setWord(name)
        cell.setWord2(name2)
        
        return cell
    }
}
