//
//  DishesCollectionViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

class DishesCollectionViewCell: UICollectionViewCell {
 
    struct ViewModel {
        var id: Int?
        var name: String?
        var image: String?
        var tegDish: String?
    }
    
    private var model = ViewModel()
    weak var delegate: DishWithATag?
    
    
    @IBOutlet weak var dishImage1: UIImageView!
    @IBOutlet weak var nameDishLable1: UILabel!
    @IBOutlet weak var imageButton1: UIButton!
    
    
    @IBOutlet weak var dishImage2: UIImageView!
    @IBOutlet weak var nameDishLable2: UILabel!
    @IBOutlet weak var imageButton2: UIButton!
    
    
    @IBOutlet weak var dishImage3: UIImageView!
    @IBOutlet weak var nameDishLable3: UILabel!
    @IBOutlet weak var imageButton3: UIButton!
    
    
    @IBAction func tapImageAction1(_ sender: Any) {
        delegate?.showDishFull(dish: (delegate?.dataDishes[self.imageButton1.tag])!)
    }
    
    
    @IBAction func tapImageAction2(_ sender: Any) {
        delegate?.showDishFull(dish: (delegate?.dataDishes[self.imageButton2.tag])!)
    }
    
    @IBAction func tapImageAction3(_ sender: Any) {
        delegate?.showDishFull(dish: (delegate?.dataDishes[self.imageButton3.tag])!)
    }
    
    
    
    func configureDishCell(category: [Dish], index: Int) {
        
        let element1 = category[safe: index]
        self.imageButton1.tag = index
        let element2 = category[safe: index + 1]
        self.imageButton2.tag = index + 1
        let element3 = category[safe: index + 2]
        self.imageButton3.tag = index + 2
        let urlArr = [element1?.imageURL, element2?.imageURL, element3?.imageURL]
        
        let arrVery = urlArr.compactMap({$0})
        
        
        for i in 0..<arrVery.count {

                NetworkRequest.shared.request(stringUrl: arrVery[i]) { result in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        
                        if i == 0 {
                            self.nameDishLable1.text = element1?.name
                            self.dishImage1.image = image
                            self.dishImage1.layer.cornerRadius = 10
                            self.dishImage1.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
                        } else if i == 1 {
                            self.nameDishLable2.text = element2?.name
                            self.dishImage2.image = image
                            self.dishImage2.layer.cornerRadius = 10
                            self.dishImage2.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
                        } else if i == 2 {
                            self.nameDishLable3.text = element3?.name
                            self.dishImage3.image = image
                            self.dishImage3.layer.cornerRadius = 10
                            self.dishImage3.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
                        }

                    case .failure(let error ):
                        print(error.localizedDescription)
                    }
                }
            
        }
        
    }
    
    
    
    
    
}
