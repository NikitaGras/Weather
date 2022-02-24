//
//  LocationServiceImp.swift
//  The Weather
//
//  Created by Nikita Gras on 19.02.2021.
//

import CoreLocation
import UIKit

class LocationServiceImp: NSObject, LocationService {
    var locationManager = CLLocationManager()
    var observers = [WeakBox]()
    static let shared = LocationServiceImp()

    override private init() {
        super.init()
        locationManager.delegate = self
    }
    
    func accessGranted() -> Bool {
        return locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse
    }
    
    func register(_ observer: LocationObserver) {
        let weakBox = WeakBox(observer)
        observers.append(weakBox)
        getLocation(observer)
    }
    
    func getLocation(_ observer: LocationObserver) {
        guard let location = locationManager.location else {return}
        observer.notify(didGetLocation: location)
    }
}

extension LocationServiceImp: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            observers.forEach { (observer) in
                observer.object?.notifyAuthDenied()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        observers.forEach { (observer) in
            observer.object?.notify(didGetLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observers.forEach { (observer) in
            observer.object?.notify(didGetError: error)
        }
    }
}
