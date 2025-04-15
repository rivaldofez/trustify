//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import TrustifyCore
import Combine

public protocol ClaimInteractorProtocol {
    var claimUseCase: ClaimUseCaseProtocol { get set }
    
    func getClaimList() -> AnyPublisher<[ClaimModel], CustomError>
}

public class ClaimInteractor: ClaimInteractorProtocol {
    public var claimUseCase: ClaimUseCaseProtocol
    
    init() {
        self.claimUseCase = DIContainer.shared.inject(type: ClaimUseCaseProtocol.self)
    }
    
    public func getClaimList() ->  AnyPublisher<[ClaimModel], CustomError> {
        return self.claimUseCase.getClaimList()
    }
}
