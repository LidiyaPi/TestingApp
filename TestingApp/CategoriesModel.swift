//
//  CategoryModel.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit
import Foundation


struct Categories: Decodable {
    let сategories: [ArrayCategories]
}

struct ArrayCategories: Decodable {
    var id: Int
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageUrl = "image_url"
    }
}

struct MenuModel: Decodable {
    let dishes: [Dishes]
}

struct Dishes: Decodable {
    var id: Int
    var name: String
    var price: Int
    var weight: Int
    var description: String
    var imageUrl: String
    var tegs: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case weight = "weight"
        case description = "description"
        case imageUrl = "image_url"
        case tegs = "tegs"
    }
}

struct Tegs {
    var title: String
    var dishes: [Dishes]
}

struct SortedDishes {
    var dishes: [String: [Any]]
}
