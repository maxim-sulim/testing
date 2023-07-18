//
//  ZoomDishViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 03.07.2023.
//

import UIKit


class ZoomDishViewController: UIViewController {
    
    
    private var storage: UserStorageProtocol = UserStorage()
    
    
    @IBOutlet weak var favoriteBatton: UIButton!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var nameDish: UILabel!
    @IBOutlet weak var priceAndPortion: UILabel!
    @IBOutlet weak var discriptionDish: UILabel!
    
    
    @IBOutlet weak var toBascketTap: BascketButton!
    
    @IBAction func toBascketTapAction(_ sender: Any) {
        
        let oldDish = storage.loadBascket()
        var newDish = [UserModelBascketProtocol]()
        var isSelect = false
        
        
        if oldDish.count >= 1 {
            
            for dish in 0..<oldDish.count {
                if oldDish[dish].nameDish == userModel.first?.nameDish {
                    newDish = storage.changeCountObject(nameObject: oldDish[dish].nameDish, upOrDown: true)
                    isSelect = true
                }
            }
            
            if isSelect == false {
                newDish.append(contentsOf: oldDish)
                newDish.append(userModel.first!)
            }
            storage.saveBascket(userModel: newDish)
            
        } else {
            
            storage.saveBascket(userModel: userModel)
        }
        
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func favoriteTapButton(_ sender: Any) {
        
        let favoriteDish: UserModelFavoriteProtocol = UserModelFavorite(nameDish: userModel.first!.nameDish,
                                                                        imageURL: userModel.first!.imageURL,
                                                                        orders: "0")
        var fullFavorite = storage.loadFavorite()
        
        for index in 0..<fullFavorite.count {
            
            if fullFavorite[index].nameDish == favoriteDish.nameDish {
                storage.deleteFavoriteDish(favoriteNameDish: userModel.first!.nameDish)
                self.favoriteBatton.backgroundColor = .white
                return
            }
        }
        
        fullFavorite.append(favoriteDish)
        storage.saveFavorite(userModel: fullFavorite)
        
        self.activeFavorite = true
        self.favoriteBatton.backgroundColor = Resources.Color.activeBlu
        
    }
    
    
    
    @IBAction func canccelXtap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var cancelXtapAction: UIButton!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var userModel = [UserModelBascketProtocol]()
    var activeFavorite = false
    
     private func configureView() {
        self.view.backgroundColor = .clear.withAlphaComponent(0.5)
        self.backgroundView.layer.cornerRadius = 20
        self.backgroundView.backgroundColor = .white
        self.dishImage.backgroundColor = Resources.Color.tagsBackground
        self.dishImage.layer.cornerRadius = 15
        self.cancelXtapAction.backgroundColor = .white
        self.cancelXtapAction.layer.cornerRadius = 10
        self.favoriteBatton.layer.cornerRadius = 10
        
         if activeFavorite == false {
             self.favoriteBatton.backgroundColor = .white
         } else {
             self.favoriteBatton.backgroundColor = Resources.Color.activeBlu
         }
        
    
        self.dishImage.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
        
    }
    
    func configureDishCell(dish: Dish) {
        
        let urlImage = dish.imageURL
        
        let userModelLocal: UserModelBascketProtocol = UserModelBascket(nameDish: dish.name, price:  dish.price, weight:  dish.weight, imageURL:  dish.imageURL, countDish: 1, favorite: false)
        userModel.append(userModelLocal)
        
        DispatchQueue.main.async {
            
            NetworkRequest.shared.request(stringUrl: urlImage) { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    
                    self.dishImage.image = image
                    
                    
                case .failure(let error ):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        let check = storage.checkFavorite(dish: dish.name)
        
        if check == true {
            self.activeFavorite = true
            self.viewDidLoad()
        }
    }
    
    
    
}
