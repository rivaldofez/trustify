//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case general
    case timeout
    case notFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case redirection
    case clientError
    case invalidResponse(httpStatusCode: Int)
    case statusMessage(message: String)
    case decodingError(Error)
    case connectionError(Error)
    case unauthorizedClient
    case urlError(URLError)
    case httpError(HTTPURLResponse)
    case type(Error)
    case alamofire(AFError)
}
