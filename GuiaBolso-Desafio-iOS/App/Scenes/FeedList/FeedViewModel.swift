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
    func getCategory(at indexPath: IndexPath) -> CategoryModel
    func loadCategories()
    var state: Bindable<FeedViewControllerStates> { get }
}

class FeedViewModel: FeedViewModelProtocol {
    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var categories: [CategoryModel] = []
    private let service: ServiceProtocol
    
    init(serviceProtocol: ServiceProtocol = Service()) {
        self.service = serviceProtocol
    }
    
    func numberOfRowsInSection() -> Int {
        categories.count
    }
    
    func getCategory(at indexPath: IndexPath) -> CategoryModel {
        return categories[indexPath.row]
    }
    
    func loadCategories() {
        let apiEnv = ApiEnvironment()
        guard let apiUrl = apiEnv.apiUrl else { return state.value = .error }
         
        service.getCategoriesList(from: apiUrl) { categories in
            self.categories.append(contentsOf: categories)
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
