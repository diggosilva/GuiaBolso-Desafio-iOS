//
//  JokeModel.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 23/01/25.
//

import Foundation

class JokeModel: Codable {
    let iconUrl: String
    let url: String
    let value: String
    
    init(iconUrl: String, url: String, value: String) {
        self.iconUrl = iconUrl
        self.url = url
        self.value = value
    }
}
