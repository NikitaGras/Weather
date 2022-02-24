//
//  WeakBox.swift
//  The Weather
//
//  Created by Nikita Gras on 23.02.2021.
//

import Foundation

class WeakBox {
    private(set) weak var object: LocationObserver?
    
    init(_ object: LocationObserver) {
        self.object = object
    }
}
