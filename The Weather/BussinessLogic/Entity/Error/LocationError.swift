//
//  LocationError.swift
//  The Weather
//
//  Created by Nikita Gras on 19.02.2021.
//

import Foundation

enum LocationError: LocalizedError {
    case `default`
    
    var errorDescription: String? {
        switch self {
        case .`default`:
            return "Пожалуйста предоставьте доступ к вашему местоположению в настройках телефона!"
        }
    }
}
