//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation

public protocol RequestBuilder: NetworkTarget {
    init(request: NetworkTarget)
    var pathAppendedURL: URL { get }
    func setQuery(to urlRequest: inout URLRequest)
    func encodedBody() -> Data?
    func buildURLRequest() -> URLRequest
}
