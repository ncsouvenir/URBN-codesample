//
//  VenueSearchModel.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

//formula: prefix+width+"x"+height+suffix

struct AllVenues: Codable {
    let responseVenue: ResponseVenue
    
    enum CodingKeys: String, CodingKey {
        case responseVenue = "response"
    }
}

struct ResponseVenue: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let id: String
    let name: String
    let contact: Contact
    let location: Location
    let categories: [Category]
    let menu: Menu
}

struct Contact: Codable {
    let formattedPhone: String?
}

struct Location: Codable {
    let address: String?
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let distance: Double?
    let postalCode: String?
    let city: String?
    let state: String
}

struct Category: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
}


struct Menu: Codable {
    let mobileURL: String?
}






