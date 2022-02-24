//
//  LocationServiceDelegate.swift
//  The Weather
//
//  Created by Nikita Gras on 22.02.2021.
//

import CoreLocation

protocol LocationObserver: class {
    func notify(didGetLocation location: CLLocation)
    func notify(didGetError error: Error)
    func notifyAuthDenied()
}
