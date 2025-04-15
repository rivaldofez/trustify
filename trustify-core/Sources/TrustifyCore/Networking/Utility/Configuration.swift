//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation

enum BaseURLType {
    case production
    case staging

    var value: URL {
        switch self {
        case .production:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else { fatalError("Invalid URL")}
            return url
        case .staging:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else { fatalError("Invalid URL")}
            return url
        }
    }
}

enum VersionType {
    case none
    var value: String {
        switch self {
        case .none:
            return ""
        }
    }
}
