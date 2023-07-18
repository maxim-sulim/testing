//
//  BascketButton.swift
//  testingUp
//
//  Created by Максим Сулим on 09.07.2023.
//

import UIKit


class BascketButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.backgroundColor = Resources.Color.activeBlu
        self.tintColor = .white
    }
    
    
    

}
