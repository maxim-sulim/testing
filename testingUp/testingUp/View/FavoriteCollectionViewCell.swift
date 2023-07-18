//
//  FavoriteCollectionViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 14.07.2023.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGroundView: UIImageView!
    
    @IBOutlet weak var imageDish: UIImageView!
    
    @IBOutlet weak var nameDish: UILabel!
    
    @IBOutlet weak var countOrdersDish: UILabel!
    
    
    func configureCollectionCell(favoriteDish: UserModelFavoriteProtocol) {
        
        self.backGroundView.layer.cornerRadius = 20
        self.backGroundView.backgroundColor = Resources.Color.activeBlu.withAlphaComponent(0.4)
        self.imageDish.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
        self.imageDish.layer.cornerRadius = 10
        self.nameDish.text = favoriteDish.nameDish
        self.countOrdersDish.text = "\(favoriteDish.orders) заказов"
        
        DispatchQueue.main.async {
            
            NetworkRequest.shared.request(stringUrl: favoriteDish.imageURL) { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    
                    self.imageDish.image = image
                    self.imageDish.backgroundColor = .gray.withAlphaComponent(0.5)
                    
            
                case .failure(let error ):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
