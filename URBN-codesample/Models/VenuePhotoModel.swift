//
//  VenuePhotoModel.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

struct AllPhotos: Codable {
    let response: Response
}

struct Response: Codable {
    let photos: VenuePhotos
}

struct VenuePhotos: Codable {
    let items: [Photo]
}

struct Photo: Codable {
    let id: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
}
