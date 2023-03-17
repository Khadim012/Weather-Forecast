//
//  HomeView.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 16/03/2023.
//

import UIKit

class HomeView: UIView {

    @IBOutlet var txtSearch: UITextField!{
        didSet {
            txtSearch.returnKeyType = .search
            txtSearch.enablesReturnKeyAutomatically = false
        }
    }
    
    @IBOutlet weak var tbCitiesList: UITableView!{
        didSet{
            tbCitiesList.register(UINib(nibName: "CityWeatherCC", bundle: nil), forCellReuseIdentifier: "CityWeatherCC")
            
        }
    }
}
