//
//  UIButton+AsyncloadImage.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// load image asynchronously
    func loadImageAsynchronously(url: URL?, completion: ((_ result: Bool) -> Void)? = nil) {
        
        if url == nil {
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.setImage(UIImage(data: data), for: .normal)
                        self.imageView?.contentMode = .scaleAspectFill
                        self.contentHorizontalAlignment = .fill
                        self.contentVerticalAlignment = .fill
                        completion?(true)
                    } else {
                        print("image data is nil!")
                        completion?(false)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
