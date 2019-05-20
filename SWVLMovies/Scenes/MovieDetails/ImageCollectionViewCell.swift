//
//  ImageCollectionViewCell.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Kingfisher
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.kf.cancelDownloadTask()
    }
    
    func configureCell(with url: URL) {
        image.kf.indicatorType = .activity
        image.kf.indicator?.startAnimatingView()
        image.kf.setImage(with: url, placeholder: UIImage(named: "swvl"), options: nil, progressBlock: nil) { (result: Result<RetrieveImageResult, KingfisherError>) in
            self.image.kf.indicator?.stopAnimatingView()
        }
    }
    
}
