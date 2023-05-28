//
//  ViewController.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import UIKit

protocol FilterPokemonsDelegate: AnyObject {
    func filter(type: String)
}

class FilterPokemonsViewController: UIViewController {
    weak var delegate: FilterPokemonsDelegate?
    let reuseIdentifier = "Cell"
    var types: [String] = PokemonType.allCases.map { $0.rawValue }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilterPokemonsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up your collection view
        collectionView.showsHorizontalScrollIndicator = false
        view = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        types.sort()
    }
}

    // MARK: UICollectionViewDataSource
extension FilterPokemonsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FilterPokemonsCollectionViewCell else { return UICollectionViewCell() }
        let type = types[indexPath.item]
        cell.configure(text: type)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate else { return }
        let type = types[indexPath.item]
        delegate.filter(type: type)
    }
}
    // MARK: UICollectionViewDelegateFlowLayout
extension FilterPokemonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.bounds.width - 16) / 2
        return CGSize(width: itemSize, height: itemSize/4)
    }
}
