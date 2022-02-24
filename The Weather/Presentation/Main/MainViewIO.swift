//
//  MainViewIO.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import Foundation

protocol MainViewInput: class, ViewInput {
    func fill(with weather: Weather)
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func hideContent()
    func showContent()
}

protocol MainViewOutput {
    func viewIsReady()
    func retryRequest()
}
