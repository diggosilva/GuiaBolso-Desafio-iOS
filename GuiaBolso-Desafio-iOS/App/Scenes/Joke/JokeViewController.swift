//
//  JokeViewController.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 23/01/25.
//

import UIKit

class JokeViewController: UIViewController {
    
    let jokeView = JokeView()
    let viewModel: JokeViewModel
    
    init(category: String) {
        self.viewModel = JokeViewModel(category: category)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = jokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
        viewModel.loadJoke()
    }
    
    private func handleStates() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                return self.showLoadingState()
            case .loaded(let jokeModel):
                return self.showLoadedState(jokeModel: jokeModel)
            case .error:
                return self.showErrorState()
            }
        }
    }
    
    private func showLoadingState() {
        jokeView.spinner.startAnimating()
        jokeView.loadingLabel.isHidden = false
    }
    
    private func showLoadedState(jokeModel: JokeModel) {
        jokeView.setAlphaView(duration: 0.25, alpha: 1)
        jokeView.configure(model: jokeModel)
        jokeView.spinner.stopAnimating()
        jokeView.loadingLabel.isHidden = true
    }
    
    private func showErrorState() {
        let alert = UIAlertController(title: "Acredite se quiser!", message: "Chuck Norris está com problemas. 🤣", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Entendi", style: .default) { action in
            self.jokeView.bgCard.isHidden = true
            self.jokeView.fgCard.isHidden = true
            self.jokeView.spinner.stopAnimating()
            self.jokeView.loadingLabel.text = "Tente mais tarde! 🥲"
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
