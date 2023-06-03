import UIKit
import RxSwift
import ProgressHUD
import MaterialColor

class PokemonListViewController: UIViewController {
    private let viewModel = PokemonListViewModel()
    private let disposeBag = DisposeBag()
    private var pokemons: [PokemonViewModel] = []
    
    private lazy var labelFilter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Filter by type:"
        label.textColor = MaterialColor.black
        label.numberOfLines = 1
        return label
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
        
        ProgressHUD.show()
        viewModel.loadPokemonData()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.pokemonList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.configureSubviews()
                self.pokemons.append(contentsOf: result)
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ProgressHUD.dismiss()
        }
    }
    
    private func configureSubviews() {
        view.addSubview(labelFilter)
        view.addSubview(filterCollectionView.view)
        view.addSubview(tableView)
        addChild(filterCollectionView)
        filterCollectionView.didMove(toParent: self)
        configureConstrainsts()
    }
    
    private func configureConstrainsts() {
        labelFilter.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingLeft: 8,
                           paddingBottom: 8)
        filterCollectionView.view.anchor(top: labelFilter.bottomAnchor,
                                         left: view.leftAnchor,
                                         right: view.rightAnchor,
                                         paddingTop: 12,
                                         height: 50)
        tableView.anchor(top: filterCollectionView.view.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension PokemonListViewController: FilterPokemonsDelegate {
    func filter(type: String) {
        let result = pokemons.filter { $0.type.rawValue == type }
        viewModel.pokemonList.onNext(result.count > 0 ? result : pokemons)
    }
}
