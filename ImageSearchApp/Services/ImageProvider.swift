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
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL, completion: ((UIImage, URL) -> Void)?) {
        if let image = cache.object(forKey: url as NSURL) {
            completion?(image, url)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data, let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    completion?(image, url)
                }
            }
        }.resume()
    }
}
