//
//  FlickrPhoto.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

struct FlickrPhoto: Photo, Decodable {
    
    // The title of the photo
    let title: String
    
    // The url for retrieving the image
    var imageURL: URL {
        let string = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        return URL(string: string)!
    }
    
    // Mark: - Private
    
    private let id: String
    private let farm: Int
    private let secret: String
    private let server: String
}
