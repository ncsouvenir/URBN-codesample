//
//  FoursquareAPIService.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

class FourSquareAPIService{
    
    private init(){}
    static let service = FourSquareAPIService()
    
    
    //MARK: getting all results from query
    func getVenueResults(lat latitute: Double,
                         lon longitude: Double,
                         query: String,
                         completion: @escaping ([Venue]) -> Void, errorHandler: @escaping (Error) -> Void){
        //building version parameter for API endpoint
        let dateFormatted = DateFormatter()
        let date = Date()
        dateFormatted.dateFormat = "yyyyMMdd"
        let dateAsStr = dateFormatted.string(from: date)
        
        let urlStr = "https://api.foursquare.com/v2/venues/search?ll=\(latitute,longitude)&query=\(query)&client_id=\(FourSquareAPIKeys.clientID)&client_secret=\(FourSquareAPIKeys.clientKey)&v=\(dateAsStr)"
        //guard valid url
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL(url: urlStr))
            return
        }
        //url request
        let request = URLRequest(url: url)
        //networkhelper call
        NetworkHelper.manager.performDataTask(with: request, completionHandler: { (data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(AllVenues.self, from: data)
                let searchedVenue = results.responseVenue.venues
                completion(searchedVenue)
            } catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }, errorHandler: errorHandler)
    }
    
    //MARK: function to get details for queried venue --> Used in DetailedVenueVC
    func getVenueDetails(venue venueID: String,
                         completion: @escaping ([VenueDetails]) -> Void,
                         errorHandler: @escaping (Error) -> Void){
        //building version parameter for API endpoint
        let dateFormatted = DateFormatter()
        let date = Date()
        dateFormatted.dateFormat = "yyyyMMdd"
        let dateAsStr = dateFormatted.string(from: date)
        
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)?client_id=\(FourSquareAPIKeys.clientID)&client_secret=\(FourSquareAPIKeys.clientKey)&v=\(dateAsStr)"
        
        //guard valid url
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL(url: urlStr))
            return
        }
        //url request
        let request = URLRequest(url: url)
        //networkhelper call
        NetworkHelper.manager.performDataTask(with: request, completionHandler: { (data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(AllVenueDetails.self, from: data)
                let detailedVenue = results.response.venue
                completion([detailedVenue])
            } catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }, errorHandler: errorHandler)
    }
    
}
