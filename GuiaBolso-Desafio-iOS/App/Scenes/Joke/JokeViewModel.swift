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

class JokeViewModel {
    var state: Bindable<JokeViewControllerStates> = Bindable(value: .loading)
    var service: ServiceProtocol = Service()
    let category: String
    
    init(category: String) {
        self.category = category
    }
    
    func loadJoke() {
        state.value = .loading
        service.getJoke(category: category) { joke in
            self.state.value = .loaded(joke)
        } onError: { erro in
            self.state.value = .error
        }
    }
}
