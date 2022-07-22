//
//  Double+Extenions.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

extension Double {
    
    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self)

        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
    
    func rounded(toPlaces places: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double {
        let divisor = pow(10.0, Double(places))
        return ((self * divisor).rounded(rule) / divisor)
    }
    
    func volumeFormat(fractionDigits: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = fractionDigits
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    func limitDecimalDigits(numberOfDecimals: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = numberOfDecimals
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}
