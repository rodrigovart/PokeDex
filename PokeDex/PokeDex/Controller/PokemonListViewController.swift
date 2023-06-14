//
//  PokemonListViewController.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 06/05/23.
//

import UIKit
import RxSwift
import ProgressHUD
import MaterialColor

class PokemonListViewController: UIViewController {
    static let shared = PokemonListViewController()
    private let viewModel = PokemonListViewModel()
    private let disposeBag = DisposeBag()
    
    var pokemons: [PokemonViewModel] = []
    
    private lazy var resetAllPokemons: UIButton = {
        let button = UIButton()
        guard let image = UIImage(systemName: "arrow.2.circlepath.circle")
        else { return UIButton() }
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.anchor(width: 50, height: 50)
        return button
    }()
    
    private lazy var filterPokemons: UIButton = {
        let button = UIButton()
        guard let image = UIImage(systemName: "magnifyingglass.circle")
        else { return UIButton() }
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(searchPokemonsInList), for: .touchUpInside)
        button.anchor(width: 50, height: 50)
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Procurar por Nome"
        return searchBar
    }()

    private lazy var filterCollectionView: FilterPokemonsViewController = {
        let collectionView = FilterPokemonsViewController()
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonCollectionViewCell.self, forCellReuseIdentifier: "PokemonCollectionViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PokéDex"
        view.backgroundColor = .white
        viewModel.loadPokemonData()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.pokemonList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.configureSubviews()
                if self.pokemons.count == 0 {
                    self.pokemons.append(contentsOf: result)
                }
                self.tableView.reloadData()
                ProgressHUD.dismiss()
            }).disposed(by: disposeBag)
    }
    
    private func configureSubviews() {
        view.addSubview(filterCollectionView.view)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: resetAllPokemons)
        configureConstrainsts()
    }
    
    private func configureConstrainsts() {
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             paddingTop: 8)
        filterCollectionView.view.anchor(top: searchBar.bottomAnchor,
                                         left: view.leftAnchor,
                                         right: view.rightAnchor,
                                         paddingTop: 12,
                                         height: 100)
        tableView.anchor(top: filterCollectionView.view.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8)
    }
    
   @objc private func reset() {
        viewModel.pokemonList.onNext(pokemons)
    }
    
    @objc func searchPokemonsInList(with text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if text.isEmpty {
                self.viewModel.pokemonList.onNext(self.pokemons)
            } else {
                self.viewModel.pokemonList.onNext(self.pokemons)
                let result = self.viewModel.pokemonListValue.filter { $0.name.contains(text) }
                print(result)
                self.viewModel.pokemonList.onNext(result)
            }
        }
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonListValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else { return UITableViewCell() }
        let pokemon = viewModel.pokemonListValue[indexPath.item]
        cell.configure(with: pokemon)
        cell.layoutIfNeeded()
        
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dump(viewModel.pokemonListValue[indexPath.row])
        let viewController = PokemonDetailsViewController()
        viewController.pokemon = viewModel.pokemonListValue[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PokemonListViewController: FilterPokemonsDelegate {
   func filter(type: String) {
        ProgressHUD.show()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if type.toPokemonType() == .reset {
                self.viewModel.pokemonList.onNext(self.pokemons)
            } else {
                self.viewModel.pokemonList.onNext(self.pokemons)
                let result = self.viewModel.pokemonListValue.filter { $0.type.contains(type.toPokemonType()) }
                self.viewModel.pokemonList.onNext(result)
            }
        }
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.lowercased()
        searchPokemonsInList(with: text)
    }
}

