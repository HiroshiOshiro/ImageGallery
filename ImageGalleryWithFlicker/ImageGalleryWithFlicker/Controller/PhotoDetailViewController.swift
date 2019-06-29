//
//  PhotoDetailViewController.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit
import WebKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var takenOnLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var descriptionBaseView: UIView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPhotoData()
    }
    
    // MARK: - private methods
    private func setUpPhotoData() {
        if let url = URL(string: photo?.media["m"] ?? "") {
            imageView.loadImageAsynchronously(url: url, completion: {[weak self] (result) in
                if result {
                    if let weakSelf = self { weakSelf.loadingIndicator.stopAnimating()
                    }
                }
            })
        }
        
        authorLabel.text = photo?.author
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM dd, yyyy", options: 0, locale: Locale(identifier:"en_US_POSIX"))
        takenOnLabel.text = formatter.string(from: photo?.dateTaken ?? Date())
        tagsLabel.text = photo?.tags

        // not sure but description contain html..
        let descriptionWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: descriptionBaseView.frame.width, height: descriptionBaseView.frame.height))
        descriptionWebView.loadHTMLString(photo?.description ?? "", baseURL: nil)
        descriptionBaseView.addSubview(descriptionWebView)
    }
}
