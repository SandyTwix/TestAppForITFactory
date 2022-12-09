//
//  NetworkManager.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit

final class NetworkManager {
    
    func GetData(completion: @escaping(EatingData) -> ()) {
        if let path = Bundle.main.path(forResource: "jsonfile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let toGo = try JSONDecoder().decode(EatingData.self, from: data)
                completion(toGo)
            } catch {
                print("Error! API is does not working...")
                print(error)
            }
        }
    }
    
    func GetPicturesFromUrl(completion: @escaping (URL) -> ()){
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {return}
        var task: URLSessionDataTask!
        
        if let task = task {
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Data is not loaded from API....")
                return
            }
            
            if let _ = error {
                return
            }
            
            do {
                let getImages: RandomImage = try JSONDecoder().decode(RandomImage.self, from: data)
                let pathForImage = getImages.message
                
                completion(URL(string: pathForImage) ?? URL(string: "https://www.purinaone.ru/dog/sites/default/files/2020-07/zuby-u-sobak-mobile-min_1.jpg")!)
            } catch {
                print("Error! Image is not loaded from API...")
                print(error)
            }
        }
        task.resume()
    }
}

