//
//  CustomImageView.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let linkCache = NSCache<AnyObject, AnyObject>()

    class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    var imageIndexPath: IndexPath?
    let networkManager = NetworkManager()
    
    func LoadImage(indexPath: IndexPath, closure: @escaping () -> ()) {
        imageIndexPath = indexPath
        image = nil
        
        if let imageCache = imageCache.object(forKey: indexPath as AnyObject) as? UIImage {
            image = imageCache
            closure()
            
            return
        }
        
        if let task = task {
            task.cancel()
        }
        
        networkManager.GetPicturesFromUrl { [weak self] url in
            self?.task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                
                guard let data = data, let img = UIImage(data: data) else { return }
                
                imageCache.setObject(img, forKey: indexPath as AnyObject)
                
                DispatchQueue.main.async {
                    if self?.imageIndexPath == indexPath {
                        self?.image = img
                        closure()
                    }
                }
            }
            self?.task.resume()
        }
    }
}
