//
//  Photo.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let title: String
    let link: String
    let media: [String: String]
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorId: String
    let tags: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }
}



