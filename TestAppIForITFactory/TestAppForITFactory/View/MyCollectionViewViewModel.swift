//
//  MyCollectionViewViewModel.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import Foundation

    class MyCollectionViewModel {
    weak var delegate: CollectionViewModelDelegate?
    private let networkManager = NetworkManager()
    var eatingData: EatingData?
    
    init() {
        networkManager.GetData { [unowned self] data in
            eatingData = data
            delegate?.reloadData()
        }
    }
    
    func numberOfSection() -> Int {
        guard let data = eatingData else { return 0 }
        
        return data.sections.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard let data = eatingData else { return 0 }
        
        return data.sections[section].items.count
    }
}

protocol CollectionViewModelDelegate: AnyObject {
    func reloadData()
}



