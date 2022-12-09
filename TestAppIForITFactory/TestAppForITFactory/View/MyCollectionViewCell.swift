//
//  MyCollectionViewCell.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

    class MyCollectionViewCell: UICollectionViewCell {
    static let reuseID = "CollectionCell"
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.text = "Mindful Eating Practice: Eating With Our Eyes"
        title.font = UIFont(name: "MarkPro-Bold", size: 14)
        title.textColor = UIColor.black
        title.textAlignment = .left
        return title
    }()
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        AddToSubview()
        SettingsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func AddToSubview() {
        addSubview(view)
        view.addSubview(imageView)
        view.addSubview(blurView)
        view.addSubview(title)
    }
        
    override var isSelected: Bool{
        didSet {
            if isSelected {
                layer.cornerRadius = 15
                layer.borderWidth = 4
                layer.borderColor = UIColor(named: "purple")?.cgColor
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    private func SettingsConstraints() {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            title.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -15),
            title.topAnchor.constraint(equalTo: blurView.topAnchor),
            title.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
        ])
    }
}
