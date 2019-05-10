//
//  APIClient.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 10/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

// Simple protocol to wrap a network request
protocol APIClient {
    func performRequest(with url: URL, completion: @escaping (Data?, Error?) -> Void)
}
