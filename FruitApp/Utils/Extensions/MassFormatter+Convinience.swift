//
//  MassFormatter+Convinience.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//


import Foundation

extension MassFormatter {
    static let kgs: MassFormatter = {
        let f = MassFormatter()
        f.isForPersonMassUse = false
        f.unitStyle = .medium
        return f
    }()
}

