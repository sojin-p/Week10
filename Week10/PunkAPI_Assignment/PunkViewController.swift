//
//  PunkViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import UIKit
import SnapKit

final class PunkViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BeerElement>!
    
    let viewModel = PunkViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewModel.request {
            self.updateSnapshot()
        }
        configureHierarchy()
        setConstraints()
        configureDataSource()
        updateSnapshot()
        
    }

}

// MARK: - DataSource
extension PunkViewController {
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BeerElement>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.list)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BeersCell, BeerElement> { cell, indexPath, itemIdentifier in
            cell.nameLabel.text = itemIdentifier.name
            cell.tagLineLabel.text = itemIdentifier.tagline
            cell.descriptionLabel.text = itemIdentifier.description
            
            let url = URL(string: itemIdentifier.image_url)
            cell.imageView.kf.setImage(with: url)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
}

// MARK: - Set UI
extension PunkViewController {
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
