//
//  Service.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

protocol ServiceProtocol {
    func getCategoriesList(from url: String, onSuccess: @escaping([CategoryModel]) -> Void, onError: @escaping(Error) -> Void)
    func getJoke(from url: String, category: String, onSuccess: @escaping(JokeModel) -> Void, onError: @escaping(Error) -> Void)
}

class Service: ServiceProtocol {
    var dataTask: URLSessionDataTask?
    
    func getCategoriesList(from url: String, onSuccess: @escaping([CategoryModel]) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: url) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
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
    
    func getJoke(from url: String, category: String, onSuccess: @escaping(JokeModel) -> Void, onError: @escaping(Error) -> Void) {
        guard let url = URL(string: "\(url)=\(category)") else { return }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
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
