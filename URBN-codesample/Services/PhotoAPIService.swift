//
//  PhotoAPIService.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

class PhotoAPIService {
    private init(){}
    static let service = PhotoAPIService()
    
    func getVenuePhotos(venue venueID: String, completion: @escaping ([Photo])-> Void, errorHandler: @escaping (Error)-> Void){
        
        //building version parameter for API endpoint
        let dateFormatted = DateFormatter()
        let date = Date()
        dateFormatted.dateFormat = "yyyyMMdd"
        let dateAsStr = dateFormatted.string(from: date)
        
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(FourSquareAPIKeys.clientID)&client_secret=\(FourSquareAPIKeys.clientKey)&v=\(dateAsStr)"
        
        //making sure the url is valid and intializing the URL request
        guard let url = URL(string: venueID) else {
            errorHandler(AppError.badURL(url: urlStr))
            return}
        
        let request = URLRequest(url: url)
        
        
        //option 1
        NetworkHelper.manager.performDataTask(with: request, completionHandler: { (data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(AllPhotos.self, from: data)
                if let venuePhoto = results.response.photos.items.first{
                    completion([venuePhoto])
                    print("Getting venue photos from Photo APIClient")
                }
            }catch{
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }, errorHandler: errorHandler)
        
        //
        //        //option 2
        //        let parseDataIntoPhoto: (Data) -> Void =  {(data) in
        //            do{
        //                let decoder = JSONDecoder()
        //                let results = try decoder.decode(AllPhotos.self, from: data)
        //                if let venuePhoto = results.response.photos.items.first{
        //                    completion([venuePhoto])
        //                }
        //            }catch{
        //                errorHandler(AppError.couldNotParseJSON(rawError: error))
        //            }
        //        }
        //
        //        NetworkHelper.manager.performDataTask(with: request,
        //                                              completionHandler: parseDataIntoPhoto,
        //                                              errorHandler: errorHandler)
        
    }
}
