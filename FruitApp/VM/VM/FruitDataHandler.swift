//
//  FruitDataHandler.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

struct FruitVM {
    
}

extension FruitVM {
    static func loadFruits(_ completion: @escaping (Fruits?, APIError?) -> ()) {
        FruitAPIHandler.get(endpoint: "data.json", type: Fruits.self) { (fruits, error) in
            // TODO: - Store locally in core data, sqlite, etc.....
            completion(fruits, error)
        }
    }
}

