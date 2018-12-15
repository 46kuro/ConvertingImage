//
//  SentenceConvertingCollectionViewCell.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/15.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import UIKit

class SentenceConvertingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wordLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setURL(urlString: String) {
        guard let url = URL(string: urlString),
            let imageData = try? Data(contentsOf: url) else {
                return
        }
        
//        let image = UIImage(data:imageData)
//        self.imageView.image = image
    }
    
    func setWord(_ word: String) {
//        wordLabel.text = word
    }
}
