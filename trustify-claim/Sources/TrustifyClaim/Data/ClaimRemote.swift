//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Combine
import TrustifyCore
import Alamofire

public final class WorkScheduler {
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main
    static let mainThread = DispatchQueue.main
}


protocol ClaimRemoteProtocol: AnyObject {
    func getClaimList() -> AnyPublisher<[ClaimModel], CustomError>
}

final class ClaimRemote: NetworkClientManager<HttpRequest>, ClaimRemoteProtocol {
    func getClaimList() -> AnyPublisher<[ClaimModel], CustomError> {
        self.request(request: .init(request: ClaimTarget.getClaimList), scheduler: WorkScheduler.mainScheduler, responseObject: [ClaimModel].self)
    }
}

enum ClaimTarget {
    case getClaimList
}

extension ClaimTarget: NetworkTarget {
    var parameters: [String : Any]? {
        return nil
    }
    
    var cachePolicy: URLRequest.CachePolicy? {
        return nil
    }
    
    var timeoutInterval: TimeInterval? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var queryParams: [String : String]? {
        return nil
    }
    
    var bodyEncoding: TrustifyCore.BodyEncoding? {
        return nil
    }
    
    
    var baseURL: BaseURLType {
        return .production
    }
    
    var version: VersionType {
        return .none
    }
    
    var path: String? {
        return "posts"
    }
    
    var methodType: HTTPMethod {
        .get
    }
    
    var queryParamsEncoding: TrustifyCore.URLEncoding? {
        return .default
    }
}

