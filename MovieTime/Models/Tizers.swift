//
//  Tizers.swift
//  MovieTime
//
//  Created by JAHONGIR on 14/09/23.
//

import Foundation

// MARK: - Welcome
struct TizerModel: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: TizerPageInfo?
    let items: [TizerItem]?
}

// MARK: - Item
struct TizerItem: Codable {
    let kind, etag: String?
    let id: TizerID?
}

// MARK: - ID
struct TizerID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - PageInfo
struct TizerPageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
