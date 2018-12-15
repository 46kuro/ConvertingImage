//
//  SentenceConvertingViewController.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import UIKit

class SentenceConvertingViewController: UIViewController {

    @IBOutlet weak var textImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 3.0
        flowLayout.itemSize = CGSize(width: 100.0, height: 100.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        textImageCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        textImageCollectionView.dataSource = self
        
        textImageCollectionView.register(SentenceConvertingCollectionViewCell.self,
                                         forCellWithReuseIdentifier: "id")
    }
}

extension SentenceConvertingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = textImageCollectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? SentenceConvertingCollectionViewCell else {
            return SentenceConvertingCollectionViewCell()
        }
        cell.setURL(urlString: "https://fujifilm.jp/personal/digitalcamera/x/fujinon_lens_xf16mmf14_r_wr/sample_images/img/index/ff_xf16mmf14_r_wr_004.JPG")
        cell.setWord("Dog")
        return cell
    }
}
