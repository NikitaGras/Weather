//
//  WeatherServiceImp.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import Alamofire
import CoreLocation

class WeatherServiceImp: WeatherService {
    
    private let appId = "689313a1ed737437404f79a609fc3355"
    static let shared = WeatherServiceImp()
    
    private init() {}
    
    func getWeather(by location: CLLocation, completionHandler: @escaping (Weather?, Error?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let lat = location.coordinate.latitude.description
        let lon = location.coordinate.longitude.description
        let param: [String: Any] = ["appid": self.appId, "lat": lat, "lon": lon]
        
        AF.request(url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let dict = data as? [String:Any] else {
                    completionHandler(nil, SystemError.default)
                    return
                }
                do {
                    let weather = try Weather(weatherWith: dict)
                    completionHandler(weather, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                guard let data = response.data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                      let message = json["message"] as? String
                      else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(nil, SystemError.custom(message))
            }
        }
    }
    
    func getForecast(by location: CLLocation, completionHandler: @escaping ([Weather]?, Error?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/forecast"
        let lat = location.coordinate.latitude.description
        let lon = location.coordinate.longitude.description
        let param: [String: Any] = ["appid": appId, "lat": lat, "lon": lon]
        
        AF.request(url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                do {
                    guard let json = jsonData as? [String:Any],
                          let list = json["list"] as? [[String:Any]] else {
                        throw SystemError.default
                    }
                    var forecast = [Weather]()
                    for listElement in list {
                        try forecast.append(Weather(forecastWith: listElement))
                    }
                    completionHandler(forecast, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                guard let data = response.data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                      let message = json["message"] as? String else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(nil, SystemError.custom(message))
            }
        }
    }
}
