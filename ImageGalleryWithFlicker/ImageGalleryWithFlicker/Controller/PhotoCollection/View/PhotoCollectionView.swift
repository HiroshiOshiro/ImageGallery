//
//  PhotoCollectionView.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/30.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewDelegate {
    func photoSelected(photo: Photo)
}

class PhotoCollectionView: CustomViewBase {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    // photo data array
    var photos: [Photo]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var delegate: PhotoCollectionViewDelegate?
    
    func setUpWithData(photos: [Photo]?, delegate: PhotoCollectionViewDelegate) {
        self.photos = photos
        self.delegate = delegate
        collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.frame.width / 2, height: self.frame.width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
}

extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell else {
            fatalError("Failed to reuse cell")
        }
        
        // make sure indexPath.row is less than number of photos
        if indexPath.row <= self.photos?.count ?? 0,
            let photo = self.photos?[indexPath.row] {
            cell.setUpWithPhotoData(photo: photo, delegate: self)
        }
        return cell
    }
}

extension PhotoCollectionView: PhotoCollectionCellDelegate {
    func cellTapped(photo: Photo) {
        
    }
}
