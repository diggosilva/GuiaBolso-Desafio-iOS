//
//  FeedView.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

class FeedView: UIView {
    weak var viewController: UIViewController?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        tv.backgroundColor = .white
        return tv
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .gray
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
        backgroundColor = .white
        addSubviews([tableView, spinner, loadingLabel])
    }
    
    private func setConstraints() {
        let tableViewTopAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
        
        if #available(iOS 11.0, *) {
            tableViewTopAnchor = safeAreaLayoutGuide.topAnchor
        } else {
            guard let vc = viewController else { return }
            tableViewTopAnchor = vc.topLayoutGuide.topAnchor
        }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableViewTopAnchor),
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
