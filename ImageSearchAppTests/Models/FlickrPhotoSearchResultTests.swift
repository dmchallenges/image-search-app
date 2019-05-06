//
//  FlickrPhotoSearchResultTests.swift
//  ImageSearchAppTests
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import XCTest
@testable import ImageSearchApp

class FlickrPhotoSearchResultTests: XCTestCase {
    
    func testPhotoSearchResultDecoding() {
        let decoder = JSONDecoder()
        let jsonData = rawJson.data(using: .utf8)!
        let result = try? decoder.decode(FlickrPhotoSearchResult.self, from: jsonData)
        
        XCTAssertEqual(result?.page, 1)
        XCTAssertEqual(result?.pages, 1622)
        XCTAssertEqual(result?.photos.count, 2)
        XCTAssertEqual(result?.photos[0].title, "Kitten Stalked")
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
          {
            "id": "46873290495",
            "owner": "157686381@N02",
            "secret": "a86e5eb7db",
            "server": "65535",
            "farm": 66,
            "title": "IMG_2026",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0
          }
        ]
      },
      "stat": "ok"
    }
    """
}
