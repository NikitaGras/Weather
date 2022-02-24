//
//  ForecastTableViewCell.swift
//  The Weather
//
//  Created by Nikita Gras on 11.02.2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.setLocalizedDateFormatFromTemplate("HH:mm")
        return df
    }()
    
    func fill(with weather: Weather) {
        let date = dateFormatter.string(from: weather.date)
        dateLabel.text = date
        
        let temperature = "\(weather.temreature.description)°C"
        temeratureLabel.text = temperature
        
        let humidity = "humidity \(weather.humidity.description) %"
        humidityLabel.text = humidity
        
        let url = URL(string: "https://openweathermap.org/img/w/\(weather.imageName).png")
        stateImageView.kf.setImage(with: url)
    }
}
