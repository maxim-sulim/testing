//
//  UserStorage.swift
//  testingUp
//
//  Created by Максим Сулим on 11.07.2023.
//

import Foundation

protocol UserStorageProtocol {
    func loadBascket() -> [UserModelBascketProtocol]
    func saveBascket(userModel: [UserModelBascketProtocol])
    func changeCountObject(nameObject: String, upOrDown: Bool) -> [UserModelBascketProtocol]
    func removeBascket()
    func setupFavoriteBascket(nameDish: String)
    
    func loadFavorite() -> [UserModelFavoriteProtocol]
    func saveFavorite(userModel: [UserModelFavoriteProtocol])
    func removeFavorite()
    func deleteFavoriteDish(favoriteNameDish: String)
    func checkFavorite(dish: String) -> Bool
    
    func loadAccount() -> UserModelAccountProtocol
    func saveAccount(userAcc: UserModelAccountProtocol)
    func deleteAccountUser()
}

class UserStorage: UserStorageProtocol {
    
    private var storage = UserDefaults.standard
    private var storageBascketKey = "storageBascket"
    private var storageFavoriteKey = "storageFavorite"
    private var storageAccountKey = "storageAccount"
    
    private enum DishKeyBascket: String {
        case nameDish
        case price
        case weight
        case imageURL
        case countDish
        case favorite
    }
    
    private enum DishKeyFavorite: String {
        case nameDish
        case imageURL
        case orders
    }
    
    private enum UserKeyAccount: String {
        case nameUser
        case imageAccount
        case location
    }
    
    func saveAccount(userAcc: UserModelAccountProtocol) {
        
        var newElementForStorage: Dictionary<String, Any> = [:]
        
        newElementForStorage[UserKeyAccount.nameUser.rawValue] = userAcc.nameUser
        newElementForStorage[UserKeyAccount.imageAccount.rawValue] = userAcc.imageAccount
        newElementForStorage[UserKeyAccount.location.rawValue] = userAcc.location
        
        storage.set(newElementForStorage, forKey: storageAccountKey)
    }
    
    func loadAccount() -> UserModelAccountProtocol {
        
        
        let accountStorage = storage.dictionary(forKey: storageAccountKey)
        
           let name = accountStorage![UserKeyAccount.nameUser.rawValue]
           let image = accountStorage![UserKeyAccount.imageAccount.rawValue]
           let location = accountStorage![UserKeyAccount.location.rawValue]
        
        
        let accountUser: UserModelAccountProtocol = UserModelAccount(nameUser: name as! String, imageAccount: image as! Data, location: location as! String)
         return accountUser
    }
    
    func loadFavorite() -> [UserModelFavoriteProtocol] {
        var resultDishes: [UserModelFavoriteProtocol] = []
        
        let dishes = storage.array(forKey: storageFavoriteKey) as? [[String:String]] ?? []
        
        for dish in dishes {
            guard let name = dish[DishKeyFavorite.nameDish.rawValue],
                    let image = dish[DishKeyFavorite.imageURL.rawValue],
                    let orders = dish[DishKeyFavorite.orders.rawValue]  else {
                
                continue
            }
            
            resultDishes.append(UserModelFavorite(nameDish: name, imageURL: image, orders: orders))
        }
        
        return resultDishes
    }
    
    func loadBascket() -> [UserModelBascketProtocol] {
        var resultDishes: [UserModelBascketProtocol] = []
        
        let dishes = storage.array(forKey: storageBascketKey) as? [[String:Any]] ?? []
        
        for dish in dishes {
            guard let name = dish[DishKeyBascket.nameDish.rawValue],
                    let price = dish[DishKeyBascket.price.rawValue],
                    let weith = dish[DishKeyBascket.weight.rawValue],
                    let image = dish[DishKeyBascket.imageURL.rawValue],
                    let count = dish[DishKeyBascket.countDish.rawValue],
                    let favorite = dish[DishKeyBascket.favorite.rawValue]  else {
                
                continue
            }
            
            resultDishes.append(UserModelBascket(nameDish: name as! String,
                                          price: price as! Int,
                                          weight: weith as! Int,
                                          imageURL: image as! String,
                                          countDish: count as! Int,
                                          favorite: favorite as! Bool ))
        }
        
        return resultDishes
    }
    
    
    func saveBascket(userModel: [UserModelBascketProtocol]) {
       
        var arrUserDishBascket = [[String:Any]]()
        
        userModel .forEach { dish in
            var newElementForStorage: Dictionary<String, Any> = [:]
            newElementForStorage[DishKeyBascket.nameDish.rawValue] = dish.nameDish
            newElementForStorage[DishKeyBascket.price.rawValue] = dish.price
            newElementForStorage[DishKeyBascket.weight.rawValue] = dish.weight
            newElementForStorage[DishKeyBascket.imageURL.rawValue] = dish.imageURL
            newElementForStorage[DishKeyBascket.countDish.rawValue] = dish.countDish
            newElementForStorage[DishKeyBascket.favorite.rawValue] = dish.favorite
            
            arrUserDishBascket.append(newElementForStorage)
        }
        
        storage.set(arrUserDishBascket, forKey: storageBascketKey)
    }
    
    func saveFavorite(userModel: [UserModelFavoriteProtocol]) {
       
        var arrUserDishFavorite = [[String:String]]()
        
        userModel .forEach { dish in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[DishKeyFavorite.nameDish.rawValue] = dish.nameDish
            newElementForStorage[DishKeyFavorite.imageURL.rawValue] = dish.imageURL
            newElementForStorage[DishKeyFavorite.orders.rawValue] = dish.orders
            
            arrUserDishFavorite.append(newElementForStorage)
        }
        
        storage.set(arrUserDishFavorite, forKey: storageFavoriteKey)
    }
    
    
    func removeBascket() {
        storage.removeObject(forKey: storageBascketKey)
    }
    
    func removeFavorite() {
        storage.removeObject(forKey: storageFavoriteKey)
    }
    
    func deleteAccountUser() {
        storage.removeObject(forKey: storageAccountKey)
    }
    
    func changeCountObject(nameObject: String, upOrDown: Bool) -> [UserModelBascketProtocol] {
        
        var arrUserDishBascket = [[String:Any]]()
        var resultUserDish = [UserModelBascketProtocol]()
        
        let dishes = storage.array(forKey: storageBascketKey) as? [[String:Any]] ?? []
        
        for dish in dishes {
            
            if dish[DishKeyBascket.nameDish.rawValue] as! String == nameObject {
                
                var newElementForStorage: Dictionary<String, Any> = [:]
                newElementForStorage[DishKeyBascket.nameDish.rawValue] = dish[DishKeyBascket.nameDish.rawValue]
                newElementForStorage[DishKeyBascket.price.rawValue] = dish[DishKeyBascket.price.rawValue]
                newElementForStorage[DishKeyBascket.weight.rawValue] = dish[DishKeyBascket.weight.rawValue]
                newElementForStorage[DishKeyBascket.imageURL.rawValue] = dish[DishKeyBascket.imageURL.rawValue]
                newElementForStorage[DishKeyBascket.favorite.rawValue] = dish[DishKeyBascket.favorite.rawValue]
                
                if upOrDown == true {
                    let count: Int = dish[DishKeyBascket.countDish.rawValue] as! Int
                    newElementForStorage[DishKeyBascket.countDish.rawValue] =  count + 1
                } else {
                    let count: Int = dish[DishKeyBascket.countDish.rawValue] as! Int
                    newElementForStorage[DishKeyBascket.countDish.rawValue] = count - 1
                    
                    if newElementForStorage[DishKeyBascket.countDish.rawValue] as! Int  == 0 {
                        continue
                    }
                }
                
                arrUserDishBascket.append(newElementForStorage)
                
            } else {
                
                var newElementForStorage: Dictionary<String, Any> = [:]
                
                newElementForStorage[DishKeyBascket.nameDish.rawValue] = dish[DishKeyBascket.nameDish.rawValue] as? String
                newElementForStorage[DishKeyBascket.price.rawValue] = dish[DishKeyBascket.price.rawValue] as? Int
                newElementForStorage[DishKeyBascket.weight.rawValue] = dish[DishKeyBascket.weight.rawValue] as? Int
                newElementForStorage[DishKeyBascket.imageURL.rawValue] = dish[DishKeyBascket.imageURL.rawValue] as? String
                newElementForStorage[DishKeyBascket.countDish.rawValue] = dish[DishKeyBascket.countDish.rawValue] as? Int
                newElementForStorage[DishKeyBascket.favorite.rawValue] = dish[DishKeyBascket.favorite.rawValue] as? Bool
                
                arrUserDishBascket.append(newElementForStorage)
                
            }
            
        }
        
        storage.removeObject(forKey: storageBascketKey)
        
        for dish in arrUserDishBascket {
            
            guard let name = dish[DishKeyBascket.nameDish.rawValue],
                    let price = dish[DishKeyBascket.price.rawValue],
                    let weith = dish[DishKeyBascket.weight.rawValue],
                    let image = dish[DishKeyBascket.imageURL.rawValue],
                    let count = dish[DishKeyBascket.countDish.rawValue],
                    let favorite = dish[DishKeyBascket.favorite.rawValue] else {
                
                continue
            }
            
            resultUserDish.append(UserModelBascket(nameDish: name as! String,
                                            price: price as! Int,
                                            weight: weith as! Int,
                                            imageURL: image as! String,
                                            countDish: count as! Int,
                                            favorite: favorite as! Bool))
        }
        
        return resultUserDish
    }
    // на выходе массив с апнутым блюдом и пустое хранилище, привожу к типу словаря для потенциалньой вохможности загрузки в хранилище
    
    func checkFavorite(dish: String) -> Bool {
        var result = false
        
        let dishes = storage.array(forKey: storageFavoriteKey) as? [[String:String]] ?? []
        
        for element in dishes {
            
            guard let name = element[DishKeyFavorite.nameDish.rawValue] else {
                continue
            }
            
            if name  == dish  {
                result = true
            }
        }
    
        return result
    }
    
    func setupFavoriteBascket(nameDish: String) {
        
        let dishes = storage.array(forKey: storageBascketKey) as? [[String:Any]] ?? []
        var arrUserDish = [[String:Any]]()
        
        for dish in dishes {
            
            var newElementForStorage: Dictionary<String, Any> = [:]
            
            newElementForStorage[DishKeyBascket.nameDish.rawValue] = dish[DishKeyBascket.nameDish.rawValue]
            newElementForStorage[DishKeyBascket.price.rawValue] = dish[DishKeyBascket.price.rawValue]
            newElementForStorage[DishKeyBascket.weight.rawValue] = dish[DishKeyBascket.weight.rawValue]
            newElementForStorage[DishKeyBascket.imageURL.rawValue] = dish[DishKeyBascket.imageURL.rawValue]
            newElementForStorage[DishKeyBascket.countDish.rawValue] = dish[DishKeyBascket.countDish.rawValue]
            
            if dish[DishKeyBascket.nameDish.rawValue] as! String == nameDish {
                newElementForStorage[DishKeyBascket.favorite.rawValue] = true
            } else {
                newElementForStorage[DishKeyBascket.favorite.rawValue] = dish[DishKeyBascket.favorite.rawValue]
            }
            
            arrUserDish.append(newElementForStorage)
        }
        
        storage.removeObject(forKey: storageBascketKey)
        storage.set(arrUserDish, forKey: storageBascketKey)
    }
    
    func deleteFavoriteDish(favoriteNameDish: String) {
        
        var arrUserDishFavorite = [[String:String]]()
        let dishes = storage.array(forKey: storageFavoriteKey) as? [[String:String]] ?? []
        
        for dish in dishes {
            guard let name = dish[DishKeyFavorite.nameDish.rawValue],
                  let image = dish[DishKeyFavorite.imageURL.rawValue],
                  let order = dish[DishKeyFavorite.orders.rawValue] else {
                continue
            }
            if name == favoriteNameDish {
                continue
            } else {
                var newElement: Dictionary<String,String> = [:]
                newElement[DishKeyFavorite.nameDish.rawValue] = name
                newElement[DishKeyFavorite.imageURL.rawValue] = image
                newElement[DishKeyFavorite.orders.rawValue] = order
                arrUserDishFavorite.append(newElement)
            }
            
        }
        
        storage.set(arrUserDishFavorite, forKey: storageFavoriteKey)
        
    }
    
    
}
