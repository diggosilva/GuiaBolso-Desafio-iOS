//
//  FeedViewModel.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

enum FeedFeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> Model
    func loadCategories()
    var state: Bindable<FeedFeedViewControllerStates> { get }
}

class FeedViewModel {
    private(set) var state: Bindable<FeedFeedViewControllerStates> = Bindable(value: .loading)
    var categories: [Model] = []
    private let service: ServiceProtocol = Service()
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Model {
        return categories[indexPath.row]
    }
    
    func loadCategories() {
        state.value = .loading
        service.getCategoriesList { categories in
            self.categories.append(contentsOf: categories)
            self.state.value = .loaded
        } onError: { error in
            print("Erro no serviço: \(error.localizedDescription)")
            self.state.value = .error
        }
    }
}
