//
//  ClaimViewController.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import UIKit

public protocol ClaimViewProtocol: AnyObject {
    var presenter: ClaimPresenterProtocol? { get set }
}

public class ClaimViewController: UIViewController {
    public var presenter: ClaimPresenterProtocol?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getClaimList()
    }
}

extension ClaimViewController: ClaimViewProtocol {
    
}
