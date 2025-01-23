//
//  Service.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

protocol ServiceProtocol {
    func getCategoriesList(onSuccess: @escaping([Model]) -> Void, onError: @escaping(Error) -> Void)
}

class Service: ServiceProtocol {
    var dataTask: URLSessionDataTask?
    let apiUrl = "https://api.chucknorris.io/jokes/categories"
    
    func getCategoriesList(onSuccess: @escaping([Model]) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: apiUrl) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("DEBUG: StatusCode.. \(response.statusCode)")
            }
            
            if let data = data {
                print("DEBUG: Dados Recebidos.. \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode([String].self, from: data ?? Data())
                    var categories: [Model] = []
                    
                    for category in response {
                        let model = Model(category: category)
                        categories.append(model)
                    }
                    onSuccess(categories)
                    print("DEBUG: Lista de Categorias.. \(categories)")
                } catch {
                    onError(error)
                    print("DEBUG: Erro ao decodificar lista de Categorias.. \(error.localizedDescription)")
                }
            }
        })
        dataTask?.resume()
    }
}
