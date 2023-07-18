//
//  UserModel.swift
//  testingUp
//
//  Created by Максим Сулим on 11.07.2023.
//

import Foundation

protocol UserModelBascketProtocol {
    
    var nameDish: String { get set }
    var price: Int { get set }
    var weight: Int { get set }
    var imageURL: String { get set }
    var countDish: Int { get set }
    var favorite: Bool { get set }
}


struct UserModelBascket: UserModelBascketProtocol {
    
    var nameDish: String
    var price: Int
    var weight: Int
    var imageURL: String
    var countDish: Int
    var favorite: Bool
}

protocol UserModelFavoriteProtocol {
    
    var nameDish: String { get set }
    var imageURL: String { get set }
    var orders: String { get set }
    
}

struct UserModelFavorite: UserModelFavoriteProtocol {
    
    var nameDish: String
    
    var imageURL: String
    
    var orders: String
    
}

protocol UserModelAccountProtocol {
    
    var nameUser: String { get set }
    var imageAccount: Data { get set }
    var location: String { get set }
}

struct UserModelAccount: UserModelAccountProtocol {
    var nameUser: String
    
    var imageAccount: Data
    
    var location: String
}


