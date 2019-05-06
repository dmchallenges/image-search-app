//
//  FlickrPhotoTests.swift
//  ImageSearchAppTests
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import XCTest
@testable import ImageSearchApp

class FlickrPhotoTests: XCTestCase {
    
    func testPhotoDecoding() {
        let decoder = JSONDecoder()
        let jsonData = rawPhotoJson.data(using: .utf8)!
        let photo = try? decoder.decode(FlickrPhoto.self, from: jsonData)
        
        XCTAssertEqual(photo?.title, "IMG_2026")
        XCTAssertEqual(photo?.imageURL.absoluteString, "https://farm66.static.flickr.com/65535/46873290495_a86e5eb7db.jpg")
    }

    private let rawPhotoJson =
    """
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
    """
}

