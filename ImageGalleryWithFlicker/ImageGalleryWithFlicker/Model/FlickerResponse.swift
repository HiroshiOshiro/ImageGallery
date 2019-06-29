//
//  FlickerResponse.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import Foundation

struct FlickerResponse: Codable {
    let title: String
    let link: String
    let description: String
    let items: [Photo]
    let modified: Date
    let generator: String
}
