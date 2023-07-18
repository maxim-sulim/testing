//
//  NetworkModel.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import Foundation


import Foundation

// MARK: - Categories
struct ResultsCategories: Codable {
    let сategories: [Сategory]
}

// MARK: - Сategory
struct Сategory: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

// MARK: - Dishes
struct ResultsDishes: Codable {
    let dishes: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let id: Int?
    let name: String
    let price, weight: Int
    let description: String?
    let imageURL: String
    let tegs: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}
