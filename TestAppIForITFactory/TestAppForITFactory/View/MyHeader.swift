//
//  MyHeader.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

    class MyHeader: UICollectionReusableView {
    static let reuseID = "Header"

    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont(name: "MarkPro-Bold", size: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        AddToSubview()
        SettingConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func AddToSubview() {
        addSubview(title)
    }
    
    private func SettingConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
