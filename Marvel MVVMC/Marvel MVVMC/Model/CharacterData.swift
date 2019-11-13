//
//  CharacterData.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 07/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let data: CharacterList
}

// MARK: - CharacterList
struct CharacterList: Codable {
    let offset, limit, total, count: Int
    let results: [CharacterDetail]
}

// MARK: - CharacterDetail
struct CharacterDetail: Codable {
    let id: Int
    let name: String
    let resultDescription: String
    let thumbnail: Thumbnail

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case resultDescription = "description"
        case thumbnail
    }
}



// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}


