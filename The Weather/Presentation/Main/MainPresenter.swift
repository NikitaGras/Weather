//
//  MainPresenter.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import UIKit
import CoreLocation

class MainPresenter: MainViewOutput {
    let weatherService: WeatherService = WeatherServiceImp.shared
    var locationService: LocationService = LocationServiceImp.shared
    
    weak var view: MainViewInput!
    
    init(view: MainViewController) {
        self.view = view
    }
    
    func viewIsReady() {
        self.view.startLoadingAnimation()
        locationService.register(self)
    }
    
    func retryRequest() {
        if !locationService.accessGranted() {
            notifyAuthDenied()
        }
        self.locationService.getLocation(self)
    }
    
    func didGet(_ location: CLLocation) {
        self.view.startLoadingAnimation()
        weatherService.getWeather(by: location) { [weak self] (weather, error) in
            guard let self = self else {return}
            if let weather = weather {
                self.view.showContent()
                self.view.fill(with: weather)
            }
            if let error = error {
                self.view.hideContent()
                self.view.show(error)
            }
            self.view.stopLoadingAnimation()
        }
    }
    
    func didGet(_ error: Error) {
        self.view.stopLoadingAnimation()
        self.view.hideContent()
        self.view.show(error)
    }
}


extension MainPresenter: LocationObserver {
    func notify(didGetLocation location: CLLocation) {
        didGet(location)
    }
    
    func notify(didGetError error: Error) {
        didGet(error)
    }
    
    func notifyAuthDenied() {
        self.view.stopLoadingAnimation()
        self.view.hideContent()
        view.show(LocationError.default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
}
