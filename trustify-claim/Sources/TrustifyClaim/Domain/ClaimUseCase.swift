//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Combine
import TrustifyCore

public protocol ClaimUseCaseProtocol: AnyObject {
    func getClaimList() -> AnyPublisher<[ClaimModel], CustomError>
}

final class ClaimUseCase: ClaimUseCaseProtocol {
    private let claimRemote: ClaimRemoteProtocol
    
    init(claimRemote: ClaimRemoteProtocol = DIContainer.shared.inject(type: ClaimRemoteProtocol.self)) {
        self.claimRemote = claimRemote
    }
    
//    init(musicRemote: MusicRemoteProtocol = DIContainer.shared.inject(type: MusicRemoteProtocol.self)) {
//        self.musicRemote = musicRemote
//    }
    
    func getClaimList() -> AnyPublisher<[ClaimModel], CustomError> {
        return self.claimRemote.getClaimList()
    }
}
