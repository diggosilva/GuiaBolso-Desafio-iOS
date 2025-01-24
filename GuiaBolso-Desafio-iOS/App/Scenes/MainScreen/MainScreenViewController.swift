//
//  MainScreenViewController.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

class MainScreenViewController: UIViewController {
    weak var timer: Timer?
    
    lazy var logoImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setChuckNorrisImage()
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOffset = CGSize(width: 5, height: 5)
        img.layer.shadowOpacity = 0.75
        img.layer.shadowRadius = 5.0
        img.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        img.addGestureRecognizer(tapGesture)
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startAnimateLogo()
    }
    
    @objc private func imageTapped() {
        timer?.invalidate()
        let feedVC = FeedViewController()
        navigationController?.pushViewController(feedVC, animated: true)
    }
    
    private func startAnimateLogo() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            self?.animateLogo(duration: 0.1, rotationAngle: 0.05)
        }
    }
    
    private func animateLogo(duration: CGFloat, rotationAngle: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            self.logoImage.transform = self.logoImage.transform.rotated(by: rotationAngle)
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.logoImage.transform = self.logoImage.transform.rotated(by: -rotationAngle * 2)
            }) { _ in
                UIView.animate(withDuration: duration, animations: {
                    self.logoImage.transform = self.logoImage.transform.rotated(by: rotationAngle)
                })
            }
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 300),
            logoImage.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
