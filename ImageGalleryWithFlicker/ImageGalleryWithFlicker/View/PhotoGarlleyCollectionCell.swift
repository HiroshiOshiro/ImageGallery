//
//  PhotoGarlleyCollectionCell.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class PhotoGarlleyCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpWithPhotoData(_ photo: Photo){
        if let url = URL(string: photo.media) {
            image.loadImageAsynchronously(url: url, completion: {[weak self] (result) in
                if result {
                    if let weakSelf = self { weakSelf.lodingIndicator.stopAnimating()
                    }
                }
            })
        }
    }

}
