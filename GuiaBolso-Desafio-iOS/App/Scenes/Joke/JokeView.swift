//
//  JokeView.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 23/01/25.
//

import UIKit
import SDWebImage

class JokeView: UIView {
    weak var viewController: UIViewController?
    
    lazy var bgCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyShadow(view: view)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var fgCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var jokeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        return lbl
    }()
    
    lazy var linkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.addTarget(self, action: #selector(goToJokeTapped), for: .touchUpInside)
        return btn
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
        setAlphaView(alpha: 0)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(model: JokeModel) {
        guard let url = URL(string: model.iconUrl) else { return }
        iconImage.sd_setImage(with: url)
        jokeLabel.text = model.value
        linkButton.setTitle(model.url, for: .normal)
    }
    
    @objc func goToJokeTapped() {
        guard let urlString = linkButton.titleLabel?.text,
              let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setAlphaView(duration: CGFloat = 0, alpha: CGFloat) {
        UIView.animate(withDuration: duration) {
            self.bgCard.alpha = alpha
            self.fgCard.alpha = alpha
            self.iconImage.alpha = alpha
            self.jokeLabel.alpha = alpha
            self.linkButton.alpha = alpha
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .white
        addSubviews([bgCard, fgCard, iconImage, jokeLabel, linkButton, spinner, loadingLabel])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            bgCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            bgCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            bgCard.widthAnchor.constraint(equalToConstant: 300),
            bgCard.heightAnchor.constraint(equalToConstant: 400),
            
            fgCard.topAnchor.constraint(equalTo: bgCard.topAnchor, constant: 20),
            fgCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            fgCard.leadingAnchor.constraint(equalTo: bgCard.leadingAnchor, constant: 20),
            fgCard.trailingAnchor.constraint(equalTo: bgCard.trailingAnchor, constant: -20),
            fgCard.heightAnchor.constraint(equalToConstant: 300),
            
            iconImage.topAnchor.constraint(equalTo: fgCard.topAnchor, constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: fgCard.centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            
            jokeLabel.centerXAnchor.constraint(equalTo: iconImage.centerXAnchor),
            jokeLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor),
            jokeLabel.leadingAnchor.constraint(equalTo: fgCard.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: fgCard.trailingAnchor, constant: -20),
            jokeLabel.bottomAnchor.constraint(equalTo: fgCard.bottomAnchor, constant: -20),
            
            linkButton.centerXAnchor.constraint(equalTo: bgCard.centerXAnchor),
            linkButton.topAnchor.constraint(equalTo: fgCard.bottomAnchor, constant: 10),
            linkButton.leadingAnchor.constraint(equalTo: bgCard.leadingAnchor, constant: 20),
            linkButton.trailingAnchor.constraint(equalTo: bgCard.trailingAnchor, constant: -20),
            linkButton.bottomAnchor.constraint(equalTo: bgCard.bottomAnchor, constant: -20),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10),
        ])
    }
}
