//
//  TheMainViewController.swift
//  The Weather
//
//  Created by Nikita Gras on 30.01.2021.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController, MainViewInput {
    
    @IBOutlet weak var contentContainerView: UIView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    var output: MainViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = MainPresenter(view: self)
        setupInitialState()
        output.viewIsReady()
    }
    
    func setupInitialState() {
        activityIndicator.hidesWhenStopped = true
    }
    
    func fill(with weather: Weather) {
        temperatureLabel.text = weather.temreature.description + "°C"
        descriptionLabel.text = weather.description
        let url = URL(string: "https://openweathermap.org/img/w/\(weather.imageName).png")
        weatherStateImageView.kf.setImage(with: url)
        feelsLikeLabel.text = weather.feelsLike.description + "°C"
        pressureLabel.text = weather.pressure.description + " mmHg"
        humidityLabel.text = weather.humidity.description + "%"
        minTempLabel.text = weather.tempMin.description + "°C"
        maxTempLabel.text = weather.tempMax.description + "°C"
    }
    
    func startLoadingAnimation() {
        hideContent()
        retryButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
    
    func showContent() {
        contentContainerView.isHidden = false
        retryButton.isHidden = true
    }
    
    func hideContent() {
        contentContainerView.isHidden = true
        retryButton.isHidden = false
    }
    
    @IBAction func retry(_ sender: UIButton) {
        output.retryRequest()
    }
}
