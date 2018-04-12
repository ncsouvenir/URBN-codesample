//
//  VenueDetailsModel.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation


struct AllVenueDetails: Codable {
    let response: DetailsResponse
}

struct DetailsResponse: Codable {
    let venue: VenueDetails
}

struct VenueDetails: Codable {
    let id: String
    let name: String
    let stats: Stats
    let price: Price
    let rating: Double //8.8 out of 10.0
    let shortURl: String
}

struct Stats: Codable {
    let checkinsCount: Int
}

struct Price: Codable {
    let message: String //"cheap"
    let currency: String // "$"
}
