//
//  Array + ext.swift
//  testingUp
//
//  Created by Максим Сулим on 03.07.2023.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
