//
//  FeedView.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

class FeedView: UIView {
    weak var viewController: UIViewController?
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    lazy var loadingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Carregando..."
        lbl.textColor = .gray
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        
        return lbl
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        addSubviews([tableView, spinner, loadingLabel])
    }
    
    private func setConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
                loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10),
            ])
        } else {
            guard let vc = viewController else { return }
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: vc.topLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
                loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10),
            ])
        }
    }
}
