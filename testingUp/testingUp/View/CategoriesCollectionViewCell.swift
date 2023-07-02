//
//  CategoriesCollectionViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    
    struct ViewModel {
        var id: Int?
        var name: String?
        var image: String?
    }
    
    private var model = ViewModel()
    
    weak var delegate: CategoryShow?
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var categoryLable: UILabel!
    
    @IBAction func tapCategory(_ sender: Any) {
        
        delegate?.segueNameCategory(name: model.name ?? "none")
    }
    
    func configureCategoriesCell(element: Сategory) {
        
         let urlString = element.imageURL
        model.name = element.name
            
            DispatchQueue.main.async {
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        self.categoryImage.image = image?.scale(newWidth: 352)
                        self.categoryImage.layer.cornerRadius = 20
                        
                        self.categoryLable.text = element.name
                        
                    case .failure(let error ):
                        print(error.localizedDescription)
                    }
                }
            }
            
    }
}
