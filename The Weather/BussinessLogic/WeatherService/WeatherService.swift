//
//  WeatherService.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import Foundation
import CoreLocation

protocol WeatherService {
    func getWeather(by location: CLLocation, completionHandler: @escaping (Weather?, Error?) -> Void)
    func getForecast(by location: CLLocation, completionHandler: @escaping ([Weather]?, Error?) -> Void)
}
