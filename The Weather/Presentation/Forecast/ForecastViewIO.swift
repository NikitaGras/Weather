//
//  ForecastViewIO.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import Foundation

protocol ForecastInput: class, ViewInput {
    func updateTableView()
    func setupInitialState()
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func showRetryButton()
    func hideRetryButton()
}

protocol ForecastOutput {
    var sortedForecast: [[Weather]] { get set }
    func viewIsReady()
    func retryRequest()
}
