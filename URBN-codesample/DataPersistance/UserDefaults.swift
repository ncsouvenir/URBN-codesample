//
//  UserDefaults.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

class UserPreferences {
    private init() {}
    
    static let manager = UserPreferences()
    
    private let userDefaults = UserDefaults.standard
    private let userCoordinatesLatitudeKey = "User Coordinates Latitude Key"
    private let userCoordinatesLongitudeKey = "User Coordinates Longitude Key"
    private let searchCoordinatesLatitudeKey = "Search Coordinates Latitude Key"
    private let searchCoordinatesLongitudeKey = "Search Coordinates Longitude Key"
    
    //save users location
    public func saveUserCoordinates(latitude: Double, longitude: Double) {
        userDefaults.set(latitude, forKey: userCoordinatesLatitudeKey)
        userDefaults.set(longitude, forKey: userCoordinatesLongitudeKey)
    }
    public func saveSearchCoordinates(latitude: Double, longitude: Double) {
        userDefaults.set(latitude, forKey: searchCoordinatesLatitudeKey)
        userDefaults.set(longitude, forKey: searchCoordinatesLongitudeKey)
    }
    //getting users last used location
    public func getUserCoordinate() -> (latitude: Double?, longitude: Double?) {
        let latitude = userDefaults.object(forKey: userCoordinatesLatitudeKey) as? Double
        let longitude = userDefaults.object(forKey: userCoordinatesLongitudeKey) as? Double
        return (latitude, longitude)
    }
    public func getSearchCoordinates() -> (latitude: Double?, longitude: Double?) {
        let latitude = userDefaults.object(forKey: searchCoordinatesLatitudeKey) as? Double
        let longitude = userDefaults.object(forKey: searchCoordinatesLatitudeKey) as? Double
        return (latitude, longitude)
    }
}
