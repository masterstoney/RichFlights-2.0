//
//  TripResultsView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/19/21.
//

import UIKit

class TripResultsView: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    private var layout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(196))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RFTripResultCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.isHidden = true
        return collectionView
    }()
    
    var loadingAnimationView: RFLoadingAnimationView = RFLoadingAnimationView()
    
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .secondarySystemBackground
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        addSubview(loadingAnimationView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        loadingAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingAnimationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    

}
