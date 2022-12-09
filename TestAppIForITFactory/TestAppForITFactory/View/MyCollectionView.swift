//
//  CollectionView.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

    class MyCollectionView: UIView {
    private let viewModel = MyCollectionViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseID)
        collectionView.register(MyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeader.reuseID)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SettingViews()
        AddToSubview()
        SettingConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let compositionLayout = UICollectionViewCompositionalLayout { _, _ in
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.43), heightDimension: .fractionalHeight(0.28))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
            section.orthogonalScrollingBehavior = .continuous
            
            let header = self.CreateHeader()
            section.boundarySupplementaryItems = [header]
            return section
        }
        return compositionLayout
    }
    
    private func CreateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    private func SettingViews() {
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
        collectionView.dataSource = self
    }
    
    private func AddToSubview() {
        addSubview(collectionView)
    }
    
    private func SettingConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Extension

extension MyCollectionView: CollectionViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension MyCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseID, for: indexPath) as? MyCollectionViewCell else {return UICollectionViewCell()}
        
        cell.view.ShowCustomView()
        cell.imageView.LoadImage(indexPath: indexPath) {
            DispatchQueue.main.async {
                cell.view.HideCustomView()
            }
        }
        
        if let eatingData = viewModel.eatingData,
           eatingData.sections.count >= indexPath.section,
           eatingData.sections[indexPath.section].items.count >= indexPath.row {
            
            cell.title.text = eatingData.sections[indexPath.section].items[indexPath.row].title
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyHeader.reuseID, for: indexPath) as? MyHeader else { return UICollectionViewCell() }
        
        if let eatingData = viewModel.eatingData,
           eatingData.sections.count >= indexPath.section,
           eatingData.sections[indexPath.section].items.count >= indexPath.row {
            header.title.text = eatingData.sections[indexPath.section].header
        }
        
        return header
    }
}
