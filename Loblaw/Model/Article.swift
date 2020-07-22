//
//  Article.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-20.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import Foundation

struct Listing: Codable {
    let kind: String
    let data: ListingData
}

struct ListingData: Codable {
    let children: [Article]
}

struct Article: Codable {
    let kind: String
    let data: ArticleData
}

struct ArticleData: Codable {
    let title: String
    let thumbnail: String
    let url: String
    
    var thumbnailURL: URL? {
        URL(string: thumbnail)
    }
}
