//
//  FruitAPIHandler.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

import Foundation

public enum APIError: Error, CustomStringConvertible {
    /// An error for which we don't have a specific one.
    case generic(String)
    
    /// An error holding on to an NSError.
    case nsError(Foundation.NSError)
    
    /// Human understandable error string.
    public var description: String {
        switch self {
        case .generic(let message):
            return message
        case .nsError(let error):
            return error.localizedDescription
        }
    }
}

struct FruitAPIHandler {
    
}

// MARK: - Headlines endpoint
extension FruitAPIHandler {
    static func get<T: Decodable>(endpoint: String, type: T.Type, _ completion: @escaping (T?, APIError?) -> ()) {
        guard let url = URL(string: Application.Configuration.baseURL(path: endpoint)) else {
            completion(nil, APIError.generic("Invalid API"))
            return
        }
         
        NetworkManager.HTTP.request(url: url) { (data, error) in
            if let e = error {
                completion(nil, e)
            } else {
                do {
                    let decodedObjects = try FruitsDecoders.decodeJSON(data: data!, type: T.self)
                    completion(decodedObjects, nil)
                } catch let decodeError {
                    completion(nil, decodeError as? APIError)
                }
            }
        }
    }
}
