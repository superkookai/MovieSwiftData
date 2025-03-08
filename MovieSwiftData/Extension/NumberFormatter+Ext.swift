//
//  NumberFormatter+Ext.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import Foundation

extension NumberFormatter {
    var noComma: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.alwaysShowsDecimalSeparator = false
        return formatter
    }
}
