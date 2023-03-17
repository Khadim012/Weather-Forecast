//
//  CityWeatherCC.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 16/03/2023.
//

import UIKit

class CityWeatherCC: UITableViewCell {


    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblWeatherStatus: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHeightLowTemp: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //loadiung the data
    func setCitiesData(City: CityWeatherDC) {
       
        lblCityName.text = City.name ?? ""
        lblTime.text = getDateAndTime(timeZoneIdentifier: "\(City.timezone ?? 0)")//"\(City.timezone ?? 0)"
        lblWeatherStatus.text = City.weather?.first?.info ?? ""
        lblTemp.text = "\(City.main?.temp ?? 0.0)°"
        lblHeightLowTemp.text = "H:\(City.main?.temp_max ?? 0.0)°  L:\(City.main?.temp_min ?? 0.0)°"
        lblWindSpeed.text = "Wind Speed: \(City.wind?.speed ?? 0.0)"
        
    }
    
    func getDateAndTime(timeZoneIdentifier: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:a"
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)

        return dateFormatter.string(from: Date())
    }
}
