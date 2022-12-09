//
//  MainModel.swift
//  TestAppForITFactory
//
//  Created by Руслан Трищенков on 08.12.2022.
//

import UIKit


struct EatingData: Codable {
    let sections: [Section]
}

struct Section: Codable {
    let id, header: String
    let itemsTotal, itemsToShow: Int
    let items: [Item]
}

struct AllData {
    var sections: [String: [TitleText]]
}

struct Item: Codable {
    let id: String
    let image: Image
    let title: String
}

struct Image: Codable {
    let the1X, the2X, the3X: String
    let aspectRatio: Int?
    let loopAnimation: Bool?

    enum CodingKeys: String, CodingKey {
        case the1X = "1x"
        case the2X = "2x"
        case the3X = "3x"
        case aspectRatio, loopAnimation
    }
}

struct RandomImage: Codable {
    let message: String
    let status: String
}


struct TitleText {
    var image: UIImage
    var title: String
}

