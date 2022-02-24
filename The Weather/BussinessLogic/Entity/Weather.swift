//
//  Weather.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import Foundation

struct Weather {
    
    let temreature: Double
    let imageName: String
    let description: String
    let date: Date
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    init(weatherWith json: [String:Any]) throws {
        guard let weather = json["weather"] as? [[String:Any]],
              let description = weather.first?["description"] as? String,
              let icon = weather.first?["icon"] as? String,
              let timeInterval = json["dt"] as? Double,
              let main = json["main"] as? [String:Any],
              let feelsLike = main["feels_like"] as? Double,
              let tempMin = main["temp_min"] as? Double,
              let tempMax = main["temp_max"] as? Double,
              let pressure = main["pressure"] as? Int,
              let humidity = main["humidity"] as? Int,
              let temp = main["temp"] as? Double
        else {
            throw SystemError.default
        }
        
        self.temreature = temp.kelvinToCelcius.round(digitCounts: 1)
        self.imageName = icon
        self.description = description
        self.date = Date(timeIntervalSince1970: timeInterval)
        self.feelsLike = feelsLike.kelvinToCelcius.round(digitCounts: 1)
        self.tempMin = tempMin.kelvinToCelcius.round(digitCounts: 1)
        self.tempMax = tempMax.kelvinToCelcius.round(digitCounts: 1)
        self.pressure = pressure
        self.humidity = humidity
    }
    
    init(forecastWith listElement: [String:Any]) throws {
        guard let main = listElement["main"] as? [String:Any],
              let feelsLike = main["feels_like"] as? Double,
              let tempMin = main["temp_min"] as? Double,
              let tempMax = main["temp_max"] as? Double,
              let pressure = main["pressure"] as? Int,
              let humidity = main["humidity"] as? Int,
              let temp = main["temp"] as? Double,
              let weather = listElement["weather"] as? [[String:Any]],
              let icon = weather.first?["icon"] as? String,
              let description = weather.first?["description"] as? String,
              let timeInterval = listElement["dt"] as? Double
        else {
            throw SystemError.default
        }
        
        self.temreature = temp.kelvinToCelcius.round(digitCounts: 1)
        self.imageName = icon
        self.description = description
        self.date = Date(timeIntervalSince1970: timeInterval)
        self.feelsLike = feelsLike.kelvinToCelcius.round(digitCounts: 1)
        self.tempMin = tempMin.kelvinToCelcius.round(digitCounts: 1)
        self.tempMax = tempMax.kelvinToCelcius.round(digitCounts: 1)
        self.pressure = pressure
        self.humidity = humidity
    }
}
