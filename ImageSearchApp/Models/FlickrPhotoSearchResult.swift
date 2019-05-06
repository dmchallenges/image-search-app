//
//  FlickrPhotoSearchResult.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

struct FlickrPhotoSearchResult: Decodable {
    
    // Current page that this struct represents
    let page: Int
    
    // Number of pages available
    let pages: Int
    
    // The list of photos
    let photos: [FlickrPhoto]
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let result = try values.nestedContainer(keyedBy: FlickrPhotoSearchResultKeys.self, forKey: .result)
        
        page = try result.decode(Int.self, forKey: .page)
        pages = try result.decode(Int.self, forKey: .pages)
        photos = try result.decode([FlickrPhoto].self, forKey: .photos)
    }
    
    // MARK: - Coding Keys
    
    // Coding keys for root element
    private enum CodingKeys: String, CodingKey {
        case result = "photos"
    }
    
    // Coding keys for the nested result
    private enum FlickrPhotoSearchResultKeys: String, CodingKey {
        case page
        case pages
        case photos = "photo"
    }
}
