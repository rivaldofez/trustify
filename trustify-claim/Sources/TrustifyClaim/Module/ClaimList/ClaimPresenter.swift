//
//  File.swift
//
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import Combine

public protocol ClaimPresenterProtocol {
    var view: ClaimViewProtocol? { get set }
    var interactor: ClaimInteractorProtocol? { get set }
    var router: ClaimRouterProtocol? { get set }
    
    var claimList: [ClaimModel] { get set }
    func getClaimList()
    func gotoDetailClaim(claim: ClaimModel)
}

public class ClaimPresenter: ClaimPresenterProtocol {
    public weak var view: ClaimViewProtocol?
    public var interactor: ClaimInteractorProtocol?
    public var router: ClaimRouterProtocol?
    public var cancellables = Set<AnyCancellable>()
    
    public var claimList: [ClaimModel] = []
    
    public func getClaimList() {
        interactor?.getClaimList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { claims in
                self.claimList = claims
                self.view?.updateClaim(result: claims)
            })
            .store(in: &cancellables)
        
    }
    
    public func gotoDetailClaim(claim: ClaimModel) {
        router?.gotoDetailClaim(with: claim)
    }
}
