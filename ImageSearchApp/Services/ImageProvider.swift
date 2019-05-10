//
//  ImageProvider.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 07/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import UIKit

class ImageProvider {
    
    static let shared = ImageProvider()
    
    var apiClient: APIClient = URLSessionAPIClient()
    
    func image(for url: URL, completion: ((UIImage, URL) -> Void)?) {
        
        // Checks cache first
        if let image = cache.object(forKey: url as NSURL) {
            completion?(image, url)
            return
        }
        
        // If no image available on cache, request it
        apiClient.performRequest(with: url) { [weak self] (data, error) in
            if let data = data, let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url as NSURL)
                completion?(image, url)
            }
        }
    }
    
    // MARK: - Private
    
    private let cache = NSCache<NSURL, UIImage>()
}
