//
//  NumberFormatter+Convinience.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

extension NumberFormatter {
    static let currencyUK: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        let locale = Locale(identifier: "en_UK")
        f.locale = locale
        return f
    }()
}
