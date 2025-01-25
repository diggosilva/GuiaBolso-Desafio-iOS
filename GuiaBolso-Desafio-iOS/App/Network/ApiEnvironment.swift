//
//  ApiEnvironment.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 24/01/25.
//

import Foundation

class ApiEnvironment {
    let apiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as? String
    let apiUrlBase = Bundle.main.object(forInfoDictionaryKey: "ApiUrlBase") as? String
}
