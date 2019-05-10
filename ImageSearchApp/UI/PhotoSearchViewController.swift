//
//  PhotoSearchViewController.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import UIKit

class PhotoSearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var service: PhotoSearchService?
    var photos: [Photo] = []
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let cellsPerRow: CGFloat = 3
    let cellsSpacing: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        activityIndicator.hidesWhenStopped = true
        collectionView.backgroundView = activityIndicator
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let totalSpacing = (cellsPerRow - 1) * cellsSpacing
            let itemSize = floor((collectionView.bounds.width - totalSpacing) / cellsPerRow)
            
            flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            flowLayout.minimumLineSpacing = cellsSpacing
            flowLayout.minimumInteritemSpacing = cellsSpacing
        }
    }
    
    func loadMoreResults() {
        service?.loadMoreResults {[weak self] (result) in
            switch result {
            case .success(let newPhotos):
                self?.photos += newPhotos
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func startSearchWith(string: String) {
        service = FlickrPhotoSearchService(searchString: string)
        photos = []
        collectionView.reloadData()
        activityIndicator.startAnimating()
        loadMoreResults()
    }
    
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            startSearchWith(string: text)
        }
        
        searchBar.resignFirstResponder()
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.setImageURL(url: photos[indexPath.item].imageURL)

        return cell
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastItemPath = IndexPath(item: photos.count - 1, section: 0)
        
        if indexPaths.contains(lastItemPath) {
            loadMoreResults()
        }
    }
}

