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
    
    func getClaimList()
}

public class ClaimPresenter: ClaimPresenterProtocol {
    public weak var view: ClaimViewProtocol?
    public var interactor: ClaimInteractorProtocol?
    public var router: ClaimRouterProtocol?
    public var cancellables = Set<AnyCancellable>()
    
    
    public func getClaimList() {
        interactor?.getClaimList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { claims in
                print("LOGDEBUG: claim list \(claims)")
            })
            .store(in: &cancellables)
        
    }
}
