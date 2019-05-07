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
    
    func setImageURL(url: URL) {
        imageView.image = nil
        activityIndicator.startAnimating()
        
        ImageProvider.shared.image(for: url) { [weak self] (image, imageURL) in
            guard url == imageURL else {
                return
            }
            
            self?.imageView.image = image
            self?.activityIndicator.stopAnimating()
        }
    }
    
}
