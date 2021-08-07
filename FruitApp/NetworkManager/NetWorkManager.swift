//
//  NetWorkManager.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

struct NetworkManager {
    
}

// MARK: - HTTP/HTTPS using NSURLsession
extension NetworkManager {
    struct HTTP {
        
        static var session: URLSession {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            
            let session = URLSession.init(configuration: config)
            return session
        }
        
        static func request(url: URL, _ completion: @escaping (_ data: Data?, _ error: APIError?) -> ()) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let requestStartTime = Date()

            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                let timeTakenForRequest = Date().timeIntervalSince(requestStartTime)
                let ms = timeTakenForRequest * 1000
                
                let property = EventProperty(name: "time", value: "\(ms)")
                BBCAnalytics.trackEvent(event: .load, metaData: [property])
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                
                if statusCode != 200 {
                    let string = String(data: data!, encoding: .utf8)
                    completion(nil, APIError.generic("Server error \(String(describing: string))"))
                    let property = EventProperty(name: "api-stausCode", value: "\(statusCode)")
                    BBCAnalytics.trackEvent(event: .error, metaData: [property])
                    return
                }
                
                if let e = error {
                    completion(nil, APIError.nsError(e as NSError))
                } else {
                    // FIXME: check 'data' is valid
                    
                    completion(data, nil)
                }
            })
            task.resume()
        }
    }
}

