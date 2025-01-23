//
//  Model.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

class Model: Codable, CustomStringConvertible {
    let category: String
    
    init(category: String) {
        self.category = category
    }
    
    var description: String {
        return category
    }
}
