//
//  TagsCollectionViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 03.07.2023.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel{
        var index: Int = 0
        var name: String = ""
        var isSelected: Bool = false
        
    }
    private var model = ViewModel()
    var delegate: DishWithATag?
    
    @IBOutlet weak var tagButton: UIButton!
    
    
    @IBAction func tapTagAction(_ sender: Any) {
        let element = delegate?.arrTags
        
        
        if var element = element {
            
             for i in 0..<element.count {
             if element[i].isSelected == true {
             element[i].isSelected = false
             }
             }
             
             element[model.index].isSelected = true
            delegate?.arrTags = element
            delegate?.relodDishes(tag: element[model.index].name)
        }
    }
        
        func configure(with viewModel: ViewModel) {
            
            model = viewModel
            tagButton.setTitle(viewModel.name, for: .normal)
            
            configureLableCategory(button: self.tagButton)
            
            
            if viewModel.isSelected == false {
                
                
                let fontNoActive = UIFont.systemFont(ofSize: 13)
                let myNormalAttributedTitle = NSAttributedString(string: viewModel.name,
                                                                 attributes: [NSAttributedString.Key.font: fontNoActive ])
                tagButton.setAttributedTitle(myNormalAttributedTitle, for: .normal)
                
                tagButton.setTitle(viewModel.name, for: .normal)
                tagButton.tintColor = .black
                tagButton.layer.backgroundColor = Resources.Color.tagsBackground.cgColor
                
            } else if viewModel.isSelected == true {
                
                let fontActive = UIFont.systemFont(ofSize: 13)
                
                let myActivelAttributedTitle = NSAttributedString(string: viewModel.name,
                                                                  attributes: [NSAttributedString.Key.font: fontActive ])
                tagButton.setAttributedTitle(myActivelAttributedTitle, for: .normal)
                tagButton.setTitle(viewModel.name, for: .normal)
                tagButton.tintColor = .white
                tagButton.layer.backgroundColor = Resources.Color.activeBlu.cgColor
            }
            
        }
        
        func configureLableCategory(button: UIButton) {
            
            tagButton.tintColor = Resources.Color.tagsBackground
            tagButton.layer.cornerRadius = 10
        }
        

    }



