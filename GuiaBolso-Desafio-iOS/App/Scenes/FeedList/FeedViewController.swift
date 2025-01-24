//
//  FeedViewController.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    let viewModel = FeedViewModel()
    
    override func loadView() {
        super.loadView()
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
        handleStates()
        viewModel.loadCategories()
    }
    
    private func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .loading: return self.showLoadingState()
            case .loaded: return self.showLoadedState()
            case .error: return self.showErrorState()
            }
        }
    }
    
    private func showLoadingState() {
        feedView.spinner.startAnimating()
        feedView.loadingLabel.isHidden = false
    }
    
    private func showLoadedState() {
        feedView.spinner.stopAnimating()
        feedView.loadingLabel.isHidden = true
        feedView.tableView.reloadData()
    }
    
    private func showErrorState() {
        let alert = UIAlertController(title: "Ops... Algo deu errado!", message: "Tentar novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadCategories()
        }
        
        let nok = UIAlertAction(title: "Não", style: .default) { action in
            self.feedView.spinner.stopAnimating()
            self.feedView.loadingLabel.text = "Desculpe, tente mais tarde!"
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
    
    private func setNavBar() {
        title = "Categories"
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private func setDelegatesAndDataSources() {
        feedView.tableView.delegate = self
        feedView.tableView.dataSource = self
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UITableViewCell() }
        cell.configure(model: viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let categorySelected = viewModel.didSelectRowAt(indexPath: indexPath).category
        let jokeVC = JokeViewController(categoty: categorySelected)
        jokeVC.title = categorySelected.capitalized
        navigationController?.pushViewController(jokeVC, animated: true)
    }
}
