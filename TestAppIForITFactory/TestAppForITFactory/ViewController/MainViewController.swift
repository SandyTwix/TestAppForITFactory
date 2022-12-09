//
//  MainViewController.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    private let collectionView = MyCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddToSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        SettingConstraints()
    }
    
    private func AddToSubview() {
        view.addSubview(collectionView)
    }
    
    private func SettingConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
