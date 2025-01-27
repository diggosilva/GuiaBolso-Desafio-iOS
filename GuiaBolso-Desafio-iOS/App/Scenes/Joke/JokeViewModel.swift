//
//  JokeViewModel.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 23/01/25.
//

import Foundation

enum JokeViewControllerStates {
    case loading
    case loaded(JokeModel)
    case error
}

protocol JokeViewModelProtocol {
    func loadJoke()
    var state: Bindable<JokeViewControllerStates> { get }
}

class JokeViewModel: JokeViewModelProtocol {
    private(set) var state: Bindable<JokeViewControllerStates> = Bindable(value: .loading)
    var service: ServiceProtocol = Service()
    private let category: String
    
    init(category: String, serviceProtocol: ServiceProtocol = Service()) {
        self.category = category
        self.service = serviceProtocol
    }
    
    func loadJoke() {
        let apiEnv = ApiEnvironment()
        guard let apiUrlBase = apiEnv.apiUrlBase else { return state.value = .error }
        
        service.getJoke(from: apiUrlBase, category: category) { [weak self] joke in
            guard let self = self else { return }
            self.state.value = .loaded(joke)
        } onError: { [weak self] erro in
            guard let self = self else { return }
            self.state.value = .error
        }
    }
}
