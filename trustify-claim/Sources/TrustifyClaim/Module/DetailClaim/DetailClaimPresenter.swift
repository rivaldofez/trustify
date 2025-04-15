//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation

public protocol DetailClaimPresenterProtocol {
    var router: DetailClaimRouterProtocol? { get set }
    var interactor: DetailClaimInteractorProtocol? { get set }
    var view: DetailClaimViewProtocol? { get set }
    
    var claim: ClaimModel? { get set }
}

public class DetailClaimPresenter: DetailClaimPresenterProtocol {
    public var claim: ClaimModel?
    
    public var router: DetailClaimRouterProtocol?
    public var interactor: DetailClaimInteractorProtocol?
    public var view: DetailClaimViewProtocol?

}
