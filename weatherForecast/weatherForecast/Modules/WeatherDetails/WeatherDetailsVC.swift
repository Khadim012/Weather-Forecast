//
//  WeatherDetailsVC.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 17/03/2023.
//

import UIKit
import CoreLocation

class WeatherDetailsVC: UIViewController {

    @IBOutlet var weatherDetailsView: WeatherDetailsView!

    var weatherDetails: WeatherDetailsDC?
    var currCity: CityWeatherDC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I am updating data on view class. It will clean the code
        if let city = currCity {
            self.weatherDetailsView.setCurrentCityInfo(city: city)
        }
        if let data = weatherDetails {
            self.weatherDetailsView.setWeatherData(data: data)
        }
    }
    
    @IBAction func didTapBackToHome(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}

