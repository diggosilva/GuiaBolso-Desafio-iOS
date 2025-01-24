//
//  Service.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

protocol ServiceProtocol {
    func getCategoriesList(onSuccess: @escaping([CategoryModel]) -> Void, onError: @escaping(Error) -> Void)
    func getJoke(category: String, onSuccess: @escaping(JokeModel) -> Void, onError: @escaping(Error) -> Void)
}

class Service: ServiceProtocol {
    var dataTask: URLSessionDataTask?
    let apiUrl = "https://api.chucknorris.io/jokes/categories"
    let apiUrlBase = "https://api.chucknorris.io/jokes/random?category"
    
    func getCategoriesList(onSuccess: @escaping([CategoryModel]) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: apiUrl) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("DEBUG: StatusCode.. \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode([String].self, from: data ?? Data())
                    var categories: [CategoryModel] = []
                    
                    for category in response {
                        let model = CategoryModel(category: category)
                        categories.append(model)
                    }
                    onSuccess(categories)
                } catch {
                    onError(NSError(domain: "Erro", code: -1, userInfo: [NSLocalizedDescriptionKey : "Erro"]))
                    print("DEBUG: Erro ao decodificar lista de Categorias.. \(error.localizedDescription)")
                }
            }
        })
        dataTask?.resume()
    }
    
    func getJoke(category: String, onSuccess: @escaping(JokeModel) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: "\(apiUrlBase)=\(category)") else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("DEBUG: StatusCode.. \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(JokeResponse.self, from: data ?? Data())
                    let joke = JokeModel(iconUrl: response.iconURL, url: response.url, value: response.value)
                    onSuccess(joke)
                } catch {
                    onError(NSError(domain: "Erro", code: -1, userInfo: [NSLocalizedDescriptionKey : "Erro"]))
                    print("DEBUG: Erro ao decodificar piada.. \(error.localizedDescription)")
                }
            }
        })
        dataTask?.resume()
    }
}
