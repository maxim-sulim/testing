//
//  TagsDish.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import Foundation

protocol TagsProtocol {
    var name: String { get set }
    var isSelected: Bool { get set }
}


struct Tags: TagsProtocol {
    var name: String
    
    var isSelected: Bool
    
}

enum NameTagsDish {
    static var all = "Все меню"
    static var rice = "С рисом"
    static var salads = "Салаты"
    static var fish = "С рыбой"
}
