//
//  FlickrPhotoSearchService.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 07/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

class FlickrPhotoSearchService: PhotoSearchService {
    
    // MARK: - PhotoSearchService
    
    required init(searchString: String) {
        self.searchString = searchString
    }
    
    func loadMoreResults(completion: @escaping (Result<[Photo], Error>) -> Void) {
        urlSession.dataTask(with: urlFor(page: currentPage)) { [weak self] (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let results = try JSONDecoder().decode(FlickrPhotoSearchResult.self, from: data)
                    self?.currentPage += 1
                    completion(.success(results.photos))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: - Private
    
    private let searchString: String
    private let itemsPerPage = 30
    private var currentPage = 1
    
    private lazy var urlSession = URLSession(configuration: .default)
    
    private func urlFor(page: Int) -> URL {
        var urlComponents = URLComponents(string: "https://api.flickr.com/services/rest/")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "3e7cc266ae2b0e0d78e279ce8e361736"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "safe_search", value: "1"),
            URLQueryItem(name: "text", value: searchString),
            URLQueryItem(name: "page", value: String(currentPage)),
            URLQueryItem(name: "per_page", value: String(itemsPerPage)),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        
        return urlComponents!.url!
    }
    
}
