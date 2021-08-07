//
//  Fruit.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

// MARK: - Struct describing the 'Headline' model. Implements the Decodable protocol
//
struct Fruit: CustomStringConvertible {

    // MARK: - vars
    var type: String
    var price: Double
    var weight: Double
    
    // MARK: -
    var description: String {
        let priceDescription = localisedPrice ?? "\(price)"
        return "\(type) : price \(priceDescription) : weight \(localisedWeight)"
    }
    
    // MARK: - initialiser
    public init(type: String, price: Double, weight: Double) {
        self.type = type
        self.price = price
        self.weight = weight
    }
}

extension Fruit: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
        case price
        case weight
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        price = try container.decode(Double.self, forKey: .price)
        weight = try container.decode(Double.self, forKey: .weight)
    }
}

extension Fruit {
    var localisedWeight: String {
        get {
            return MassFormatter.kgs.string(fromValue: self.weight / 1000, unit: .kilogram)
        }
    }
    
    var localisedPrice: String? {
        get {
            return NumberFormatter.currencyUK.string(from: NSNumber(value: price / 100))
        }
    }
}

struct Fruits: Decodable {
    let fruit : [Fruit]
    
    enum CodingKeys: String, CodingKey {
       case fruit
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fruit = try container.decode([Fruit].self, forKey: .fruit)
    }
}

