//
//  JokeResponse.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 23/01/25.
//

import Foundation

// MARK: - JokeResponse
struct JokeResponse: Codable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url, value
    }
}
