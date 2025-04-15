//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Alamofire

extension NetworkTarget {

    var bodyEncoding: BodyEncoding? {
        return nil
    }

    var parameters: [String: Any]? {
       return nil
    }

    var cachePolicy: URLRequest.CachePolicy? {
        return .useProtocolCachePolicy
    }

    var timeoutInterval: TimeInterval? {
        return 20.0
    }

    var headers: [String: String]? {
        ["accept": "application/json"]
    }
}

private struct HTTPHeader {
    static let contentLength = "Content-Length"
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let acceptEncoding = "Accept-Encoding"
    static let contentEncoding = "Content-Encoding"
    static let cacheControl = "Cache-Control"
    static let authorization = "Authorization"
}

public struct HttpRequest: RequestBuilder {
    
    public var baseURL: BaseURLType
    public var version: VersionType
    public var path: String?
    public var methodType: HTTPMethod
    public var queryParams: [String: String]?
    public var queryParamsEncoding: URLEncoding?
    public var headers: [String: String]?
    public var parameters: [String: Any]?
    public var bodyEncoding: BodyEncoding?
    public var cachePolicy: URLRequest.CachePolicy?
    public var timeoutInterval: TimeInterval?

    public init(request: NetworkTarget) {
        self.baseURL = request.baseURL
        self.version = request.version
        self.path = request.path
        self.methodType = request.methodType
        self.queryParams = request.queryParams
        self.queryParamsEncoding = request.queryParamsEncoding
    }

    public  var pathAppendedURL: URL {
        var url = baseURL.value
        url.appendPathComponent(version.value)
        if let path = path {
            url.appendPathComponent(path)
        }
        return url
    }

    public  func setQuery(to urlRequest: inout URLRequest) {
        guard let url = urlRequest.url else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        switch queryParamsEncoding {
        case .default:
            urlComponents?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }
        case .percentEncoded:
            urlComponents?.percentEncodedQueryItems = queryParams?.map {
                URLQueryItem(name: $0.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0.key,
                             value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0.value)
            }
        case .xWWWFormURLEncoded:
            if let queryParamsData = queryParams?.urlEncodedQueryParams().data(using: .utf8) {
                urlRequest.httpBody = queryParamsData
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: HTTPHeader.contentType)
            }
        default:
            break
        }
        
        urlRequest.url = urlComponents?.url
    }

    public  func encodedBody() -> Data? {
        guard let bodyEncoding = bodyEncoding else { return nil }
        
        switch bodyEncoding {
        case .JSON:
            return try? JSONSerialization.data(withJSONObject: parameters ?? [:])
        case .xWWWFormURLEncoded:
            return try? parameters?.urlEncodedBody()
        }
    }

    public func buildURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: pathAppendedURL)
        urlRequest.httpMethod = methodType.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let queryParams = queryParams, !queryParams.isEmpty {
            setQuery(to: &urlRequest)
        }
        
        urlRequest.httpBody = encodedBody()
        urlRequest.cachePolicy = cachePolicy ?? .useProtocolCachePolicy
        urlRequest.timeoutInterval = timeoutInterval ?? 60
        
        return urlRequest
    }
}

