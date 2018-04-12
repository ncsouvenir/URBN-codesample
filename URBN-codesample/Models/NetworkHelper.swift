//
//  NetworkHelper.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

enum AppError: Error {
    case noData
    case badUrl
    case badJSON
    case noInternet
    case codingError(rawError: Error)
    case urlError(rawError: Error)
    case otherError(rawError: Error)
}

class NetworkHelper {
    private init() {
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.noData); return}
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
                
            }
            }.resume()
    }
}

