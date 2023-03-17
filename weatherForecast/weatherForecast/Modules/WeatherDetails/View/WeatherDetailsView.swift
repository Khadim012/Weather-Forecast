//
//  WeatherDetailsView.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 17/03/2023.
//

import UIKit

class WeatherDetailsView: UIView {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var lblMaxMiniTemp: UILabel!
    @IBOutlet weak var viewWeatherStatusStack: UIStackView!

    func setCurrentCityInfo(city: CityWeatherDC) {
        
        lblCity.text = city.name ?? ""
        lblTemprature.text = "\(city.main?.temp ?? 0.0)°"
        lblMaxMiniTemp.text = "Max:\(city.main?.temp_max ?? 0.0)°  Min:\(city.main?.temp_min ?? 0.0)°"
        
    }
    
    func setWeatherData(data: WeatherDetailsDC) {
    
        if let data = data.list?.prefix(5) {
            for city in data {
                let view: WatherStatusView = UIView.fromNib()
                
                let time = city.dtTxt?.components(separatedBy: " ").last ?? ""
                view.lblTime.text = time
                view.lblStatus.text = city.weather?.first?.info ?? ""
                view.lblTemp.text = "H:\(city.main?.temp_max ?? 0.0)°   L:\(city.main?.temp_min ?? 0.0)°"
                viewWeatherStatusStack.addArrangedSubview(view)
            }
        }
    }
}
