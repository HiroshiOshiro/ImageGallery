//
//  PhotoGalleryViewController.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = FlickerAPI.init(query: nil)
        api.requestPhotoData(completion: {(photos) in
            // TODO infrate collection
            print(photos.count)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
