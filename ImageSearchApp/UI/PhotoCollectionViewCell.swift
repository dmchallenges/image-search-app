//
//  PhotoCollectionViewCell.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 07/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var currentURL: URL?
    
    func setImageURL(url: URL) {
        currentURL = url
        imageView.image = nil
        activityIndicator.startAnimating()
        
        ImageProvider.shared.image(for: url) { [weak self] (image, imageURL) in
            guard self?.currentURL == imageURL else {
                return
            }
            
            self?.imageView.image = image
            self?.activityIndicator.stopAnimating()
        }
    }
    
}
