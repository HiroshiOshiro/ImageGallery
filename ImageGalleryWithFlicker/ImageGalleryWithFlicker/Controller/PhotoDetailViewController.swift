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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Do you want to save this image?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            self.saveImage()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveImage() {
        if let image : UIImage = imageView.image {
            // saving image
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           #selector(self.didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)),
                                           nil)
        }
    }
    
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        // show message depend on result
        var message = ""
        if error != nil {
            message = "Faild to save. Please chack permisssion and strage capacity."
        } else {
            message = "Saved successfully!"
        }
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
}
