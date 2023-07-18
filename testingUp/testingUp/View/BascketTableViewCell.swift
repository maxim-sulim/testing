//
//  BascketTableViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 10.07.2023.
//

import UIKit

class BascketTableViewCell: UITableViewCell {

    private var storage: UserStorageProtocol = UserStorage()
    var cgeckFavorite = false
    
    var delegate: BascketReloadTableProtocol?
    
    @IBOutlet weak var imageDish: UIImageView!
    
    @IBOutlet weak var nameDish: UILabel!
    
    @IBOutlet weak var priceDish: UILabel!
    
    @IBOutlet weak var qualityDish: UILabel!
    
    @IBOutlet weak var minusQualityButton: UIButton!
    
    @IBOutlet weak var plusQualityButton: UIButton!
    
    @IBOutlet weak var favoriteLable: UIImageView!
    
    
    
    @IBAction func minusQualityAction(_ sender: Any) {
        let newDish = storage.changeCountObject(nameObject: dish!.nameDish, upOrDown: false)
        storage.saveBascket(userModel: newDish)
        delegate?.loadStorage()
        delegate?.reloadButtonPrice()
    }
    
    @IBAction func plusQualityAction(_ sender: Any) {
        let newDish = storage.changeCountObject(nameObject: dish!.nameDish, upOrDown: true)
        storage.saveBascket(userModel: newDish)
        delegate?.loadStorage()
        delegate?.reloadButtonPrice()
       
    }
    
    var dish: UserModelBascketProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureBascketCell(dishBascket: UserModelBascketProtocol) {
        
        dish = dishBascket
        self.nameDish.text = dishBascket.nameDish
        self.priceDish.text = "\(dishBascket.price) . \(dishBascket.weight)"
        self.minusQualityButton.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
        self.plusQualityButton.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
        self.qualityDish.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
        self.qualityDish.layer.cornerRadius = 10
        self.qualityDish.text = String(dishBascket.countDish)
        cgeckFavorite = storage.checkFavorite(dish: dishBascket.nameDish)
        if cgeckFavorite == true {
            self.favoriteLable.isHidden = false
        } else {
            self.favoriteLable.isHidden = true
        }
        
        
        DispatchQueue.main.async {
            
            NetworkRequest.shared.request(stringUrl: dishBascket.imageURL) { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self.imageDish.image = image
                    self.imageDish.layer.cornerRadius = 10
                    self.imageDish.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
                    
                case .failure(let error ):
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    

}
