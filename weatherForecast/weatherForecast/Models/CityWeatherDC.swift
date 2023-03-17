//
//  CityWeatherDC.swift
//  weatherForecast
//
//  Created by Khadim Hussain on 16/03/2023.
//

import Foundation

struct CityWeatherDC : Codable {
    
    let weather : [Weather]?
    let main : Main?
    let wind : Wind?
    let timezone : Int?
    let name : String?
    let dtTxt : String?
    let cod : Int?
    let message : String?
    let coord : coordinates?
    
    enum CodingKeys: String, CodingKey {
        
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case timezone = "timezone"
        case name = "name"
        case dtTxt = "dt_txt"
        case cod = "cod"
        case message = "message"
        case coord = "coord"
    }
}

struct WeatherDetailsDC : Codable {
    
    let cod : String?
    let list : [CityWeatherDC]?
    
    enum CodingKeys: String, CodingKey {
        
        case cod = "cod"
        case list = "list"
    }
}

struct coordinates : Codable {
    
    let lon : Double?
    let lat : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lon = "lon"
        case lat = "lat"
    }
}

struct Weather : Codable {
    
    let id : Int?
    let main : String?
    let info : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case info = "description"
        case icon = "icon"
    }
}

struct Main : Codable {
    
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Int?
    let humidity : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct Wind : Codable {
    let speed : Double?
    let deg : Int?

    enum CodingKeys: String, CodingKey {

        case speed = "speed"
        case deg = "deg"
    }
}
