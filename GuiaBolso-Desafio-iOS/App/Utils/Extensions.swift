//
//  Extensions.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit
import SDWebImage

extension UIImageView {
    static let chuckNorrisImageUrl = "https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png"
    
    func setChuckNorrisImage() {
        guard let url = URL(string: UIImageView.chuckNorrisImageUrl) else {
            print("URL inválida")
            return
        }
        self.sd_setImage(with: url)
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ addSubview($0) })
    }
}
