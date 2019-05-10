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
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        activityIndicator.hidesWhenStopped = true
        collectionView.backgroundView = activityIndicator
        
        configureFlowLayout()
    }
    
    func configureFlowLayout() {
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
        return section == 0 ? photos.count : 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos.count > 0 ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier, for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.setImageURL(url: photos[indexPath.item].imageURL)

        return cell
    }
}

extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.itemSize
        }
        
        return CGSize(width: view.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            loadMoreResults()
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.first?.section == 1 {
            loadMoreResults()
        }
    }
}
