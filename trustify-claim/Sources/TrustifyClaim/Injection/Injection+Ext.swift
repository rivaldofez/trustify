//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import TrustifyCore

extension DIContainer {
    public func registerClaimService() {
        register(type: ClaimRemoteProtocol.self, component: ClaimRemote())
        register(type: ClaimUseCaseProtocol.self, component: ClaimUseCase())
    }
}
