//
//  PhotoGarlleyCollectionCell.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

protocol PhotoCollectionCellDelegate {
    func cellTapped(photo: Photo)
}

class PhotoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    
    var photo: Photo?
    var delegate: PhotoCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadFromNib()
    }
    
    /// infrate from xib 
    private func loadFromNib() {
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func setUpWithPhotoData(photo: Photo, delegate: PhotoCollectionCellDelegate){
        self.photo = photo
        self.delegate = delegate
        
        if let url = URL(string: photo.media["m"] ?? "") {
            imageButton.loadImageAsynchronously(url: url, completion: {[weak self] (result) in
                if result {
                    if let weakSelf = self { weakSelf.lodingIndicator.stopAnimating()
                    }
                }
            })
        }
    }
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        if let photo = self.photo {
            delegate?.cellTapped(photo: photo)
        }
    }
}
