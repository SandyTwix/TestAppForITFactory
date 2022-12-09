//
//  CustomView.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

    class CustomView: UIView {
    
    private let startPoints: [NSNumber] = [-1.0, -0.5, 0.0]
    private let endPoints: [NSNumber] = [1.0, 1.5, 2.0]
    
    private let gradientBackgroundColor: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private let gradientMovingColor: CGColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    
    private let movingAnimationDuration: CFTimeInterval = 0.5
    private let delayBetweenAnimationLoops: CFTimeInterval = 1.5
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [gradientBackgroundColor, gradientMovingColor, gradientBackgroundColor]
        gradient.locations = startPoints
        self.layer.addSublayer(gradient)
        
        return gradient
    }()
    
    func StartAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startPoints
        animation.toValue = endPoints
        animation.duration = movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = movingAnimationDuration + delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        animationGroup.isRemovedOnCompletion = false
        gradient.add(animationGroup, forKey: animation.keyPath)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
    }
}




extension UIView {
    
    func ShowCustomView() {
        guard !subviews.contains(where: { $0.isKind(of: CustomView.self) }) else { return }
        
        let customView = CustomView()
        addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: topAnchor),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        customView.StartAnimating()
    }
    
    func HideCustomView() {
        subviews.first(where: { $0.isKind(of: CustomView.self) })?.removeFromSuperview()
    }
}
