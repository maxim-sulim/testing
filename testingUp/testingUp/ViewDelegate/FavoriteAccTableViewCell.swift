//
//  FavoriteAccTableViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 14.07.2023.
//

import UIKit

class FavoriteAccTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var storage: UserStorageProtocol = UserStorage()
    
    var favoriteDishes: [UserModelFavoriteProtocol] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureFavoriteCell() {
        favoriteDishes = storage.loadFavorite()
        self.collectionView.reloadData()
    }

}


extension FavoriteAccTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        guard let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FavoriteCollectionViewCell else {
            
            return cell
        }
        
        newCell.configureCollectionCell(favoriteDish: favoriteDishes[indexPath.row])
        
        
        return newCell
    }
    
    
}
