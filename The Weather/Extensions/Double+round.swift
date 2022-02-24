//
//  Double+round.swift
//  The Weather
//
//  Created by Nikita Gras on 11.02.2021.
//

import Foundation

extension Double {
    func round(digitCounts: Int) -> Double {
        let multiplayer = pow(10.0, Double(digitCounts))
        return (self * multiplayer).rounded() / multiplayer
    }
}
