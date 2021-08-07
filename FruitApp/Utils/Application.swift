//
//  Application.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

struct Application {
    
}

extension Application {
    enum AppConfiguration: Int {
        case Debug
        case TestFlight
        case AppStore
    }
    
    struct Configuration {
        
        private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        
        static var isDebug: Bool {
            #if DEBUG
                return true
            #else
                return false
            #endif
        }
        
        static var appConfiguration: AppConfiguration {
            if isDebug {
                return .Debug
            } else if isTestFlight {
                return .TestFlight
            } else {
                return .AppStore
            }
        }
        
        static func baseURL(path: String) -> String {
            switch (Configuration.appConfiguration) {
            case .Debug:
                return "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/\(path)"
            default:
                return "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/\(path)"
            }
        }
        
        static var BuildVersion: String {
            return "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")!))"
        }
        
        static var BundleName: String {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        }
        
        static var info: String {
            if isDebug {
                return "Debug version \(BuildVersion)"
            } else if isTestFlight {
                return "TestFlight version \(BuildVersion)"
            } else {
                return "App store version \(BuildVersion)"
            }
        }
        
        struct KeychainKeys {
            static var authTokenKey = "FuzzyWuzzy"
        }
    }
}
