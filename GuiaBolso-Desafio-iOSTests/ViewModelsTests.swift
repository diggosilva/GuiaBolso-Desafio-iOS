//
//  ViewModelsTests.swift
//  GuiaBolso-Desafio-iOSTests
//
//  Created by Diggo Silva on 24/01/25.
//

import XCTest
@testable import GuiaBolso_Desafio_iOS

class MockSuccess: ServiceProtocol {
    func getCategoriesList(from url: String, onSuccess: @escaping([CategoryModel]) -> Void, onError: @escaping(Error) -> Void) {
        onSuccess([
            CategoryModel(category: "Game"),
            CategoryModel(category: "Movie"),
        ])
    }
    
    func getJoke(from url: String, category: String, onSuccess: @escaping(JokeModel) -> Void, onError: @escaping(Error) -> Void) {
        onSuccess(
            JokeModel(iconUrl: "", url: "", value: "Por que a galinha atravessou a rua? Pra chegar do outro lado")
        )
    }
}

class MockFailure: ServiceProtocol {
    func getCategoriesList(from url: String, onSuccess: @escaping ([CategoryModel]) -> Void, onError: @escaping(Error) -> Void) {
        onError(NSError(domain: "Error Category", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao carregar Lista de Categorias"]))
    }
    
    func getJoke(from url: String, category: String, onSuccess: @escaping (JokeModel) -> Void, onError: @escaping(Error) -> Void) {
        onError(NSError(domain: "Error Joke", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao carregar Piada"]))
    }
}

final class GuiaBolso_Desafio_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK: FeedViewModel Tests
    func testWhenSuccessCategories() {
        var sut: FeedViewModel!
        
        sut = FeedViewModel(serviceProtocol: MockSuccess())
        sut.state.bind { state in
            XCTAssertTrue(state == .loaded)
        }
        sut.loadCategories()
        sut.state.value = .loaded
        
        let firstCategory = sut.getCategory(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCategory.category, "Game")
        
        let selectedCategory = sut.getCategory(at: IndexPath(row: 1, section: 0))
        XCTAssertEqual(selectedCategory.category, "Movie")
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
    }
    
    func testWhenFailureCategories() {
        let sut: FeedViewModel = FeedViewModel(serviceProtocol: MockFailure())
        
        sut.state.bind { state in
            XCTAssertTrue(state == .error)
        }
        sut.loadCategories()
    }
    
    // MARK: JokeViewModel Tests
    func testWhenSuccessJoke() {
        var sut: JokeViewModel!
        
        sut = JokeViewModel(category: "categoryTest", serviceProtocol: MockSuccess())
        sut.state.bind { state in
            if case .loaded(let jokeModel) = state {
                XCTAssertEqual(jokeModel.value, "Por que a galinha atravessou a rua? Pra chegar do outro lado")
            }
        }
        sut.loadJoke()
    }
    
    func testWhenFailureJoke() {
        var sut: JokeViewModel!
        sut = JokeViewModel(category: "categoryTest", serviceProtocol: MockFailure())
        
        let expectation = self.expectation(description: "Joke failed to load")
        
        sut.state.bind { state in
            if case .error = state {
                expectation.fulfill()
            }
        }
        sut.loadJoke()
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
