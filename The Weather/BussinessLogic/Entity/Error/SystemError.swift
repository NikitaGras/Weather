//
//  SystemError.swift
//  The Weather
//
//  Created by Nikita Gras on 01.02.2021.
//

import Foundation

enum SystemError: LocalizedError {
    case custom(String)
    case `default`
    
    var errorDescription: String? {
        switch self {
        case .`default`:
            return "Что-то пошло не так, попробуйте позже"
        case .custom(let message):
            return message
        }
    }
}
