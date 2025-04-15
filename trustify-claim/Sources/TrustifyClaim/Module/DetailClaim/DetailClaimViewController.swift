//
//  File.swift
//
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import UIKit

public protocol DetailClaimViewProtocol: AnyObject {
    var presenter: DetailClaimPresenterProtocol? { get set }
}

public class DetailClaimViewController: UIViewController {
    public var presenter: DetailClaimPresenterProtocol?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0 // Allows for multiple lines if needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0 // Allows for multiple lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Details" // Set the title of the detail screen
        setupViews()
        configureView()
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(idLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureView() {
        guard let claim = self.presenter?.claim else { return }
        titleLabel.text = claim.title
        descriptionLabel.text = claim.body
        idLabel.text = "ID: \(claim.id)"
    }
}

extension DetailClaimViewController: DetailClaimViewProtocol {
    
}
