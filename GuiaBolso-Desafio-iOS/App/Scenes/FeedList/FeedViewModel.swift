//
//  FeedViewModel.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import Foundation

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> CategoryModel
    func loadCategories()
    var state: Bindable<FeedViewControllerStates> { get }
}

class FeedViewModel {
    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    var categories: [CategoryModel] = []
    private let service: ServiceProtocol = Service()
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CategoryModel {
        return categories[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> CategoryModel {
        return categories[indexPath.row]
    }
    
    func loadCategories() {
        state.value = .loading
        service.getCategoriesList { categories in
            self.categories.append(contentsOf: categories)
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
