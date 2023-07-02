//
//  UIImage + ext.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

extension UIImage {
    
    func scale(newWidth: CGFloat) -> UIImage {
        
        guard self.size.width != newWidth else{return self}
        
        let scaleFactor = newWidth / self.size.width
        
        let newHeight = self.size.height * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
