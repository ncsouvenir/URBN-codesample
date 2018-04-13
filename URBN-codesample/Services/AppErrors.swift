//
//  AppErrors.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL(url:String)
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case codingError(rawError: Error)
}
