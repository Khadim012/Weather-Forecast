//
//  HomeVC.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 15/03/2023.
//

import UIKit
import CoreLocation
import MapKit

class HomeVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var homeView: HomeView!
    
    var arrCities: [CityWeatherDC]?
    let locationManager = CLLocationManager()
    var isLoaded = false
    
    var curLatitude: Double?
    var curLongitude: Double?
    var currCity: CityWeatherDC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeView.txtSearch.addTarget(self, action: #selector(performSearch(_ :)), for: .editingChanged)
        self.getLocation()
    }
    
    //TO GET THE USER LOCATION COORDINDATES
    func getLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopUpdatingLocation()
        curLatitude = locValue.latitude
        curLongitude = locValue.longitude
     
        let url = "\(Constants.appBaseURL)weather?lat=\(locValue.latitude)&lon=\(locValue.longitude)&appid=\(Constants.weatherForcastKey)&units=metric"
        
        //I add this check to load the user current location weather automaticlly on application lounch. we can handle this method also in othet ways.
        if isLoaded == false {
            isLoaded = true
            performWSToGetCitiesWeather(url: url)
        }
    }
}

extension HomeVC: UITextFieldDelegate {
    
    @objc func performSearch(_ textfield:UITextField) {
        if textfield.text?.count != 0 {
         
        }
        self.homeView.tbCitiesList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //I am creating the url here. Actually I did not used in 3rd party sdk in this application so i used apple native URLSession for API calls.
         let url = "\(Constants.appBaseURL)weather?q=\(textField.text ?? "")&appid=\(Constants.weatherForcastKey)&units=metric"
            performWSToGetCitiesWeather(url: url)
        textField.resignFirstResponder()
        return true
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Weather", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - tableView Delegates and DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCC", for: indexPath) as! CityWeatherCC
        if let cities = arrCities {
            cell.setCitiesData(City: cities[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        // We can pre load the data and on tab simply can move to next viewcontroller. I call here the API for code understanding.
        if let cities = arrCities {
            let city = cities[indexPath.row]
            currCity = city
            let url = "\(Constants.appBaseURL)forecast?lat=\(city.coord?.lat ?? 0.0)&lon=\(city.coord?.lon ?? 0.0)&appid=\(Constants.weatherForcastKey)&units=metric"
            self.performWSToGetCityWeatherDetails(url: url)
        }
    }
}

extension HomeVC {
    
    func performWSToGetCitiesWeather(url: String) {
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let responseData = try? JSONDecoder().decode(CityWeatherDC.self, from: data) {
                    DispatchQueue.main.async {
                        if responseData.cod == 200 {
                            
                            if let cities = self.arrCities, cities.count > 0 {
                                self.arrCities?.append(responseData)
                            }
                            else {
                                self.arrCities = [CityWeatherDC]()
                                self.arrCities?.append(responseData)
                            }
                            self.homeView.tbCitiesList.reloadData()
                            self.homeView.txtSearch.text = ""
                        }
                        else {
                            self.showAlert(message: responseData.message ?? "")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "city not found")
                        print("Invalid Response")}
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    func performWSToGetCityWeatherDetails(url: String) {
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let responseData = try? JSONDecoder().decode(WeatherDetailsDC.self, from: data) {
                    DispatchQueue.main.async {
                        if responseData.cod == "200" {
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherDetailsVC") as? WeatherDetailsVC
                            vc?.weatherDetails = responseData
                            vc?.currCity = self.currCity
                            vc?.modalPresentationStyle = .fullScreen
                            vc?.modalTransitionStyle = .crossDissolve
                            self.navigationController?.present(vc!, animated: true)
                        }
                        else {
                            self.showAlert(message: "city not found")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "city not found")
                        print("Invalid Response")}
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}
