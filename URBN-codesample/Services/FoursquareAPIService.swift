//
//  FoursquareAPIService.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation
import Alamofire

class FourSquareAPIService{
    
    private init(){}
    static let service = FourSquareAPIService()
    
    public func getVenues(lat latitute: Double,
                   lon longitude: Double,
                   search searchTerm: String,
                   completion: @escaping ([Venue]) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        //building api endpoint
        let urlBase = "https://api.foursquare.com/v2/venues/search"
        let dateFormatted = DateFormatter()
        let date = Date()
        dateFormatted.dateFormat = "yyyyMMdd"
        let strDate = dateFormatted.string(from: date)
        let params: [String: Any] = ["ll": "\(latitute),\(longitude)",
            "query": searchTerm,
            "limit": 20,
            "client_id": FourSquareAPIKeys.clientID,
            "client_secret": FourSquareAPIKeys.clientKey,
            "v": strDate]
        
        
        Alamofire.request(urlBase, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            switch dataResponse.result {
            case .failure(let error):
                errorHandler(AppError.other(rawError: error))
            case .success:
                if let dataError = dataResponse.error {
                    errorHandler(AppError.other(rawError: dataError.localizedDescription as! Error))
                } else if let data = dataResponse.data {
                    do {
                        let decoder = JSONDecoder()
                        let results = try decoder.decode(AllVenues.self, from: data)
                        completion(results.responseVenue.venues)
                    } catch let error {
                        errorHandler(AppError.couldNotParseJSON(rawError: error))
                    }
                }
            }
        }
    }
}


