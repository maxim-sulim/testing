//
//  Collection + ext.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return saveObject(at: index)
    }
    func saveObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
