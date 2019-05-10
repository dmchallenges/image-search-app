//
//  URLSessionAPIClient.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 10/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

class URLSessionAPIClient: APIClient {
    
    func performRequest(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
    
}
