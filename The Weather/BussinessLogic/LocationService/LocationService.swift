//
//  LocationService.swift
//  The Weather
//
//  Created by Nikita Gras on 19.02.2021.
//

import CoreLocation
import UIKit

protocol LocationService {
    func register(_ observer: LocationObserver)
    func getLocation(_ observer: LocationObserver)
    func accessGranted() -> Bool
}
