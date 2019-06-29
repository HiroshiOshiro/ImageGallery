//
//  UIImageView+AsyncLoad.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// load image asynchronously
    func loadImageAsynchronously(url: URL?, completion: ((_ result: Bool) -> Void)? = nil) {
        
        if url == nil {
            completion?(false)
        }
        
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                        completion?(true)
                    } else {
                        completion?(false)
                    }
                }
            }
            catch {
                completion?(false)
            }
        }
    }
}
