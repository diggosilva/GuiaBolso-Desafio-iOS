//
//  FeedCell.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

class FeedCell: UITableViewCell {
    static let identifier = "FeedCell"
    
    lazy var categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func configure(model: CategoryModel) {
        categoryLabel.text = model.category.capitalized
        self.accessoryType = .disclosureIndicator
    }
    
    private func setHierarchy() {
        backgroundColor = .white
        addSubview(categoryLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
