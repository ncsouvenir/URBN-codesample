//
//  PhotoAPIService.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation
import Alamofire

class PhotoAPIService {
    private init() {}
    static let service = PhotoAPIService()
    
    public func getVenuePhotos(venue venueId: String,
                               completion: @escaping ([Photo]) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        let urlBase = "https://api.foursquare.com/v2/venues/\(venueId)/photos"
        let dateFormatted = DateFormatter()
        let date = Date()
        dateFormatted.dateFormat = "yyyyMMdd"
        let strDate = dateFormatted.string(from: date)
        let params: [String: Any] = ["client_id": FourSquareAPIKeys.clientID,
                                     "client_secret": FourSquareAPIKeys.clientKey,
                                     "limit": 10,
                                     "v": strDate]
        
        
        Alamofire.request(urlBase, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            switch dataResponse.result {
            case .failure(let error):
                errorHandler(error.localizedDescription as! Error)
            case .success:
                if let error = dataResponse.error {
                    errorHandler(error.localizedDescription as! Error)
                } else if let data = dataResponse.data {
                    do {
                        let decoder = JSONDecoder()
                        let results = try decoder.decode(AllPhotos.self, from: data)
                        completion(results.response.photos.items)
                    } catch let error {
                        errorHandler(AppError.couldNotParseJSON(rawError: error.localizedDescription as! Error))
                    }
                }
            }
        }
    }
}
