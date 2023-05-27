//
//  ViewController.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import UIKit
import MaterialColor

class FilterPokemonsViewController: UIViewController {
    let reuseIdentifier = "Cell"
    var types: [String] = PokemonType.allCases.map { $0.rawValue }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = MaterialColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up your collection view
        collectionView.showsHorizontalScrollIndicator = false
        view = collectionView
        types.sort()
    }
}

    // MARK: UICollectionViewDataSource
extension FilterPokemonsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = types[indexPath.item].toPokemonType()
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.contentView.addSubview(label)
        label.text = types[indexPath.item].capitalized
        label.center(inView: cell.contentView)

        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.bounds.width - 16) / 2
        return CGSize(width: itemSize, height: itemSize/4)
    }
}
