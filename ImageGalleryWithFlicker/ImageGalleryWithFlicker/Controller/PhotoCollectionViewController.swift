//
//  PhotoCollectionViewController.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchBar: UISearchBar!
    
    // photo data array
    var photos: [Photo]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotoData()
        setUpCollection()
        setuUpSearchBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let nextVC = segue.destination as? PhotoDetailViewController
            nextVC?.photo = sender as? Photo
        }
    }
    
    // MARK: - private methods
    private func getPhotoData() {
        let api = FlickerAPI.init(query: nil)
        api.requestPhotoData(completion: {(photos) in
            print(photos.count)
            self.photos = photos
        })
    }
    
    private func setUpCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
    
    
    private func setuUpSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "Search by tag..."
            searchBar.showsCancelButton = true
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionCell else {
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

extension PhotoCollectionViewController: PhotoCollectionCellDelegate {
    func cellTapped(photo: Photo) {
        performSegue(withIdentifier: "toPhotoDetail", sender: photo)
    }
}

extension PhotoCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let api = FlickerAPI.init(query: ["tags": searchText])
        api.requestPhotoData(completion: {(photos) in
            print(photos.count)
            self.photos = photos
        })
    }
}
