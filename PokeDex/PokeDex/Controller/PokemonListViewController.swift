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
        guard let image = UIImage(systemName:  "arrow.2.circlepath.circle")
        else { return UIButton() }
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.anchor(width: 50, height: 50)
        return button
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
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: resetAllPokemons)
        configureConstrainsts()
    }
    
    private func configureConstrainsts() {
        filterCollectionView.view.anchor(top: view.safeAreaLayoutGuide.topAnchor,
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
}

extension PokemonListViewController: UITableViewDelegate {}

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
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
