import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import SDWebImage

class PokemonViewController: UIViewController {

    private let apiUrl = "https://pokeapi.co/api/v2/pokemon"
    private let disposeBag = DisposeBag()

    private let pokemonViewModel = PokemonViewModel()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: "PokemonCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        bindViewModel()
        pokemonViewModel.fetchPokemon()
    }

    private func bindViewModel() {
        pokemonViewModel.pokemon
            .bind(to: collectionView.rx.items(cellIdentifier: "PokemonCell", cellType: PokemonCell.self)) { row, data, cell in
                cell.nameLabel.text = data.name
                cell.imageView.sd_setImage(with: URL(string: data.imageUrl), completed: nil)
            }.disposed(by: disposeBag)
    }
}

extension PokemonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.2
        let height = width
        return CGSize(width: width, height: height)
    }
}

