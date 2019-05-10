//
//  FlickrPhotoSearchServiceTests.swift
//  ImageSearchAppTests
//
//  Created by Diego Marcon on 10/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import XCTest
@testable import ImageSearchApp

class FlickrPhotoSearchServiceTests: XCTestCase {
    
    func testPageIncreaseAfterSuccessfulRequest() {
        let service = FlickrPhotoSearchService(searchString: "test")
        let mockApiClient = MockAPIClient()
        service.apiClient = mockApiClient
        
        // Make first request
        service.loadMoreResults { result in }
        
        // Check if first page is 1
        let firstCalledURLString = mockApiClient.calledUrl!.absoluteString
        XCTAssertTrue(firstCalledURLString.contains("&page=1"))
        
        // Return a valid result for first request
        mockApiClient.callback?(rawJson.data(using: .utf8), nil)
        
        // Make second request
        service.loadMoreResults { result in }
        
        // Check if page was increased
        let secondCalledURLString = mockApiClient.calledUrl!.absoluteString
        XCTAssertTrue(secondCalledURLString.contains("&page=2"))
    }
    
    func testPageIncreaseAfterFailResponse() {
        let service = FlickrPhotoSearchService(searchString: "test")
        let mockApiClient = MockAPIClient()
        service.apiClient = mockApiClient
        
        // Make first request
        service.loadMoreResults { result in }
        
        // Check if first page is 1
        let firstCalledURLString = mockApiClient.calledUrl!.absoluteString
        XCTAssertTrue(firstCalledURLString.contains("&page=1"))
        
        // Return error for first request
        mockApiClient.callback?(nil, NSError())
        
        // Make second request
        service.loadMoreResults { result in }
        
        // Check if page was not increased
        let secondCalledURLString = mockApiClient.calledUrl!.absoluteString
        XCTAssertTrue(secondCalledURLString.contains("&page=1"))
    }
    
    private let rawJson =
    """
    {
      "photos": {
        "page": 1,
        "pages": 1622,
        "perpage": 2,
        "total": "162169",
        "photo": [
          {
            "id": "46873460675",
            "owner": "142138499@N08",
            "secret": "818f7f2276",
            "server": "65535",
            "farm": 66,
            "title": "Kitten Stalked",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0
          },
        ]
      },
      "stat": "ok"
    }
    """
}

private class MockAPIClient: APIClient {
    var callback: ((Data?, Error?) -> Void)?
    var calledUrl: URL?
    
    func performRequest(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        calledUrl = url
        callback = completion
    }
}
