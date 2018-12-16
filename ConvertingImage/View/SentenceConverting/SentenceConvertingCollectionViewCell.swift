//
//  SentenceConvertingCollectionViewCell.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import UIKit

class SentenceConvertingCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordLabel2: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    var presenter: SentenceConvertingPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wordLabel.isHidden = true
        wordLabel2.isHidden = true
        indicatorView.startAnimating()
    }

    func setURL(urlString: String) {
        guard let url = URL(string: urlString),
            let imageData = try? Data(contentsOf: url) else {
                return
        }
        let image = UIImage(data: imageData)
        self.imageView.image = image
        indicatorView.stopAnimating()
    }
    
    func setWord(_ word: String?) {
        guard let word = word else {
            wordLabel.isHidden = true
            return
        }
        wordLabel.isHidden = false
        wordLabel.text = word
    }
    
    func setWord2(_ word: String?) {
        guard let word = word else {
            wordLabel2.isHidden = true
            return
        }
        wordLabel2.isHidden = false
        wordLabel2.text = word
    }
}
