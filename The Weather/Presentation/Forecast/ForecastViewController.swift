//
//  ForecastViewController.swift
//  The Weather
//
//  Created by Nikita Gras on 31.01.2021.
//

import UIKit

class ForecastViewController: UIViewController, ForecastInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    var output: ForecastOutput!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.setLocalizedDateFormatFromTemplate("dd MMMM")
        return df
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output = ForecastPresenter(view: self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        tableView.rowHeight = 65
        tableView.dataSource = self
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func startLoadingAnimation() {
        tableView.isHidden = true
        retryButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
    
    func showRetryButton() {
        tableView.isHidden = true
        retryButton.isHidden = false
    }
    
    func hideRetryButton() {
        tableView.isHidden = false
        retryButton.isHidden = true
    }
    
    @IBAction func retry(_ sender: UIButton) {
        output.retryRequest()
    }
}


extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        output.sortedForecast.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = output.sortedForecast[section].first?.date else {return ""}
        let title = dateFormatter.string(from: date)
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = output.sortedForecast[section]
        return section.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell") as! ForecastTableViewCell
        cell.fill(with: output.sortedForecast[indexPath.section][indexPath.row])
        return cell
    }
}
