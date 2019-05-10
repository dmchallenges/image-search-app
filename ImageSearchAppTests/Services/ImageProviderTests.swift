//
//  ImageProviderTests.swift
//  ImageSearchAppTests
//
//  Created by Diego Marcon on 10/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import XCTest
@testable import ImageSearchApp

class ImageProviderTests: XCTestCase {
    
    func testImageCaching() {
        let mockApiClient = MockAPIClient()
        ImageProvider.shared.apiClient = mockApiClient
        let url = URL(string: "http://test")!
        
        // Request a new image
        ImageProvider.shared.image(for: url, completion: nil)
        mockApiClient.callback?(testImage?.pngData(), nil)
        
        // Check if number of requests increased to 1
        XCTAssertEqual(mockApiClient.numberOfRequests, 1)
        
        // Make second request for same image
        var returnedImage: UIImage?
        ImageProvider.shared.image(for: url) { (newImage, url) in
            returnedImage = newImage
        }
        
        // Check if returns correct image without making another request to api
        XCTAssertEqual(mockApiClient.numberOfRequests, 1)
        XCTAssertEqual(returnedImage?.pngData(), testImage!.pngData())
    }
    
    private let testImage: UIImage? = {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), true, 1.0)
        UIColor.red.set()
        UIRectFill(CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
}

private class MockAPIClient: APIClient {
    var callback: ((Data?, Error?) -> Void)?
    var numberOfRequests = 0
    
    func performRequest(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        numberOfRequests += 1
        callback = completion
    }
}
