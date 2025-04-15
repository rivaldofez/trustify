//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Combine
import Alamofire

typealias BaseAPIProtocol = NetworkClientProtocol

typealias AnyPublisherResult<M> = AnyPublisher<M, CustomError>

public protocol NetworkClientProtocol: AnyObject {
    @available(iOS 13.0, *)
    @discardableResult
    func perform<M: Decodable, T>(with request: RequestBuilder,
                                  decoder: JSONDecoder,
                                  scheduler: T,
                                  responseObject type: M.Type) -> AnyPublisher<M, CustomError> where M: Decodable, T: Scheduler
}

protocol Logging {
    func logRequest(request: URLRequest)
    func logResponse(response: URLResponse?, data: Data?)
}

public final class NetworkClient: NetworkClientProtocol {
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
    
    let logging: Logging
    
    init(logging: Logging = NetworkDebugger()) {
        self.logging = logging
    }
    
    @discardableResult
    public func perform<M, T>(with request: RequestBuilder,
                       decoder: JSONDecoder,
                       scheduler: T,
                       responseObject type: M.Type) -> AnyPublisher<M, CustomError> where M: Decodable, T: Scheduler {
        let urlRequest = request.buildURLRequest()
        self.logging.logRequest(request: urlRequest)
        
        if let reachability = NetworkReachabilityManager(), !reachability.isReachable {
            return Fail(error: CustomError.noNetwork)
                .eraseToAnyPublisher()
        }
        
        return AF.request(urlRequest)
            .validate()
            .response(completionHandler: { response in
                self.logging.logResponse(response: response.response, data: response.data)
            })
            .publishDecodable(type: M.self)
            .value()
            .mapError { error in
                return CustomError.alamofire(error)
            }
            .eraseToAnyPublisher()
    }
}

open class NetworkClientManager<Target: RequestBuilder> {
    
    public typealias AnyPublisherResult<M> = AnyPublisher<M, CustomError>
    
    public let clientURLSession: NetworkClientProtocol
    
    init(clientURLSession: NetworkClientProtocol = NetworkClient()) {
        self.clientURLSession = clientURLSession
    }
    
    public init() {
        self.clientURLSession = NetworkClient()
    }
    
    open func request<M, T>(request: Target,
                       decoder: JSONDecoder = .init(),
                       scheduler: T,
                       responseObject type: M.Type) -> AnyPublisherResult<M> where M: Decodable, T: Scheduler {
        return clientURLSession.perform(with: request, decoder: decoder, scheduler: scheduler, responseObject: type)
    }
}

