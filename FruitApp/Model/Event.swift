//
//  Event.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

enum EventType: String {
    case load = "load"
    case display = "display"
    case error = "error"
}

typealias EventProperty = (name: String, value: String)

// MARK: - Struct describing the 'Event' protocol
//
protocol Event {
    var event: EventType { get set }
    var metaData: [EventProperty] { get set }
    var date: Date { get set}
}

struct FruitsAnalyticsEvent: Event, Equatable {
    
    // MARK: - vars
    var event: EventType
    var metaData: [EventProperty]
    var date: Date
    
    // conform to Equatable
    static func ==(lhs: FruitsAnalyticsEvent, rhs: FruitsAnalyticsEvent) -> Bool {
        return lhs.event == rhs.event && lhs.date == rhs.date
    }
}

extension FruitsAnalyticsEvent {
    func url(baseURL: URL) -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "event", value: self.event.rawValue))
        for data in self.metaData {
            let queryItem = URLQueryItem(name: data.name, value: data.value)
            queryItems.append(queryItem)
        }
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
}
