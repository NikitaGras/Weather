//
//  ForecastPresenter.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import CoreLocation
import UIKit

class ForecastPresenter: ForecastOutput {
    
    let weatherService: WeatherService = WeatherServiceImp.shared
    var locationService: LocationService = LocationServiceImp.shared
    
    weak var view: ForecastInput!
    var sortedForecast = [[Weather]]()
    
    init(view: ForecastInput) {
        self.view = view
    }
    
    func viewIsReady() {
        locationService.register(self)
        view.setupInitialState()
    }
    
    func locationService(didGetLocation location: CLLocation) {
        view.startLoadingAnimation()
        weatherService.getForecast(by: location) { [ weak self ] (forecast, error) in
            guard let self = self else { return }
            if let forecast = forecast {
                self.sortedForecast = self.sort(forecast)
                self.view.updateTableView()
                self.view.hideRetryButton()
            }
            if let error = error {
                self.view.show(error)
                self.view.showRetryButton()
            }
            self.view.stopLoadingAnimation()
        }
    }

    func locationService(didGetError error: Error) {
        self.view.stopLoadingAnimation()
        self.view.showRetryButton()
        self.view.show(error)
    }
    
    func retryRequest() {
        if !locationService.accessGranted() {
            notifyAuthDenied()
        } else {
            self.locationService.getLocation(self)
        }
    }
}

extension ForecastPresenter: LocationObserver {
    
    func notify(didGetLocation location: CLLocation) {
        locationService(didGetLocation: location)
    }
    
    func notify(didGetError error: Error) {
        locationService(didGetError: error)
    }
    
    func notifyAuthDenied() {
        view.show(LocationError.default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}

extension ForecastPresenter {
    // Функция преобразует массив с прогнозом в двумерный массив, разделенный по дням
    func sort(_ forecast: [Weather]) -> [[Weather]] {
        let calendar = Calendar.current
        var sortedForecast = [[Weather]]()
        
        var forecast = forecast
        
        forecast.sort { (first, second) -> Bool in
            first.date < second.date
        }
        
        // индекс дня в секции
        var dayIndex = 0
        // массив с погодой для определённого дня
        var weatherForDay = [Weather]()
        
        for index in 0..<forecast.count {
            let currentDay = calendar.component(.day, from: forecast[index].date)
            let sectionDay = calendar.component(.day, from: forecast[dayIndex].date)
            
            if currentDay == sectionDay {
                weatherForDay.append(forecast[index])
            } else {
                sortedForecast.append(weatherForDay)
                dayIndex = index
                weatherForDay.removeAll()
                weatherForDay.append(forecast[index])
            }
        }
        sortedForecast.append(weatherForDay)
        
        return sortedForecast
    }
}
