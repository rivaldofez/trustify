//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation

public protocol DIContainerProtocol {
    func register<Service>(type: Service.Type, component: Any)
    func inject<Service>(type: Service.Type) -> Service
}

public class DIContainer: DIContainerProtocol {
    
    public static let shared = DIContainer()
    
    public init() {}
    
    var services: [String: Any] = [:]
    
    public func register<Service>(type: Service.Type, component service: Any) {
        services["\(type)"] = service
    }
    
    public func inject<Service>(type: Service.Type) -> Service {
        guard let service = services["\(type)"] as? Service else { fatalError("Invalid Injection")}
        return service
    }
}
