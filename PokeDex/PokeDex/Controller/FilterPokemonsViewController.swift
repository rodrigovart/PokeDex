//
//  FilterPokemonsViewController.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 27/05/23.
//

import MaterialColor
import UIKit

protocol FilterPokemonsDelegate: AnyObject {
    func filter(type: String)
}

class FilterPokemonsViewController: UIViewController {
    weak var delegate: FilterPokemonsDelegate?
    let reuseIdentifier = "Cell"
    var types: [String] = PokemonType.allCases.map { $0.rawValue }
    
    private lazy var labelFilter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Filter by type:"
        label.textColor = MaterialColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilterPokemonsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupSubViews()
    }
    
    private func setupSubViews() {
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(labelFilter)
        view.addSubview(collectionView)
        
        setupConstrainsts()
    }
    
    private func setupConstrainsts() {
        labelFilter.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingLeft: 8,
                           paddingBottom: 8)
        collectionView.anchor(top: labelFilter.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 8)
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
