//
//  ClaimViewController.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import UIKit

public protocol ClaimViewProtocol: AnyObject {
    var presenter: ClaimPresenterProtocol? { get set }
    
    func updateClaim(result: [ClaimModel])
}

public class ClaimViewController: UIViewController {
    public var presenter: ClaimPresenterProtocol?
    
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getClaimList()
        setupConstraints()
        setupView()
    }
    
    private func setupView() {
        title = "Claim List"
        view.backgroundColor = .systemBackground
        setupTableView(mainTableView)
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.register(ClaimTableViewCell.self, forCellReuseIdentifier: ClaimTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        self.view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ClaimViewController: ClaimViewProtocol {
    public func updateClaim(result: [ClaimModel]) {
        mainTableView.reloadData()
    }
}

extension ClaimViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.claimList.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClaimTableViewCell.identifier, for: indexPath) as? ClaimTableViewCell, let presenter = self.presenter else { return UITableViewCell() }
        
        let item = presenter.claimList[indexPath.row]
        cell.configure(with: item.title, description: item.body, id: "\(item.id)")
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter?.claimList[indexPath.row] else { return }
        
        presenter?.gotoDetailClaim(claim: item)
    }
}
