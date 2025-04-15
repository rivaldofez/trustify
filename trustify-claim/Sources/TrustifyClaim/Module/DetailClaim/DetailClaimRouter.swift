//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import UIKit

public protocol DetailClaimRouterProtocol {
    var entry: (UIViewController & UIViewController)? { get set }
    static func start(with claim: ClaimModel) -> DetailClaimRouterProtocol
}

public class DetailClaimRouter: DetailClaimRouterProtocol {
    public var entry: (UIViewController)?
    
    public static func start(with claim: ClaimModel) -> DetailClaimRouterProtocol {
        let view = DetailClaimViewController()
        let router = DetailClaimRouter()
        let presenter = DetailClaimPresenter()
        let interactor = DetailClaimInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        presenter.claim = claim
        router.entry = view
        
        return router
    }
    
    
}
