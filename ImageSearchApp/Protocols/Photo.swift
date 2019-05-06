//
//  Photo.swift
//  ImageSearchApp
//
//  Created by Diego Marcon on 06/05/19.
//  Copyright © 2019 Diego Marcon. All rights reserved.
//

import Foundation

// Protocol that represents a photo to be displayed
protocol Photo: Decodable {
    var title: String { get }
    var imageURL: URL { get }
}
