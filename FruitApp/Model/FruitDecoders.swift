//
//  FruitDecoders.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation
import Foundation

struct FruitsDecoders {
    static func decodeJSON<T: Decodable>(data: Data, type: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded: T? = try decoder.decode(T.self, from: data)
            return decoded
        } catch let e {
            let property = EventProperty(name: "JSONDecoder", value: "\(e.localizedDescription)")
            FruitAnalytics.trackEvent(event: .error, metaData: [property])
            throw APIError.generic("Invalid JSON \(T.self) \(e.localizedDescription)")
        }
    }
}

