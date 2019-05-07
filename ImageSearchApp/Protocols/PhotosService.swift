//
//  PhotosService.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 07/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

typealias PhotoSearchCompletion = (Result<[Photo], Error>) -> Void

// Protocol that defines a service for fetching paginated photos
protocol PhotoSearchService {
    
    // Initializer with the desired search string
    init(searchString: String)
    
    // Load next page
    func loadMoreResults(completion: @escaping PhotoSearchCompletion)
}
