//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation
import UIKit

public protocol ClaimRouterProtocol {
    var entry: (UIViewController & ClaimViewProtocol)? { get set }
    static func start() -> ClaimRouterProtocol
    func gotoDetailClaim(with claim: ClaimModel)
}

public class ClaimRouter: ClaimRouterProtocol {
    public var entry: (UIViewController & ClaimViewProtocol)?
    
    public static func start() -> ClaimRouterProtocol {
        let view = ClaimViewController()
        let interactor = ClaimInteractor()
        let router = ClaimRouter()
        let presenter = ClaimPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        
        router.entry = view
        return router
    }
    
    public func gotoDetailClaim(with claim: ClaimModel) {
        let router = DetailClaimRouter.start(with: claim)
        guard let destinationView = router.entry, let currentView = self.entry else { return }
        currentView.navigationController?.pushViewController(destinationView, animated: true)
    }
    
}
