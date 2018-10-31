//
//  Weather data model.swift
//  PageControl
//
//  Created by Валентина on 27/10/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import Foundation

enum PartsOfDay {
    case morning,day,evening,night
}

struct Main : Decodable {
    var data : Data
}
//  все для выведения на главный экран готово
// оба комента - в методах
//// температура по часам в методе
struct Data : Decodable{
    let request : [Request]
    var current_condition : [Current_condition]
    let weather : [Weather] // all days
}

struct Request: Decodable {
    let query: String?
    let query2: String?
}

struct Current_condition: Decodable {
    let temp_C : String
    let temp_F : String
    let weatherCode : String
    let windspeedMiles : String
    let windspeedKmph : String
    let winddir16Point : String
    let humidity : String
    let pressure : String
    let cloudcover : String
    var FeelsLikeC : String
    let FeelsLikeF : String
    let weatherDesc : [WeatherDesc]
    let weatherIconUrl : [WeatherIconUrl]
}

struct Weather: Decodable { //one day
    let date : String?
    let astronomy : [Astronomy]?
    let maxtempC : String?
    let maxtempF : String?
    let mintempC : String?
    let mintempF : String?
    let totalSnow_cm : String?
    let sunHour : String?
    let uvIndex : String?
    let hourly : [Hourly]?
}

struct Astronomy: Decodable {
    let sunrise: String
    let sunset : String
    let moonrise : String
    let moonset: String
    let moon_phase: String
    let moon_illumination : String
}

struct Hourly : Decodable{
    let time : String
    let tempC : String
    let tempF: String
    let windspeedMiles: String
    let windspeedKmph: String
    let weatherCode: String
    let weatherDesc : [WeatherDesc]
    let weatherIconUrl : [WeatherIconUrl]
    let precipMM: String
    let humidity: String
    let visibility: String
    let pressure: String
    let cloudcover:String
    let HeatIndexC: String
    let HeatIndexF: String
    let WindChillC: String
    let WindChillF: String
    let WindGustMiles: String
    let WindGustKmph: String
    let FeelsLikeC: String
    let FeelsLikeF: String
    let chanceofrain: String
    let chanceofremdry:String
    let chanceofwindy: String
    let chanceofovercast: String
    let chanceofsunshine: String
    let chanceoffrost: String
    let chanceofhightemp: String
    let chanceoffog: String
    let chanceofsnow: String
    let chanceofthunder: String
}

struct WeatherDesc : Decodable{
    let value : String
}

struct WeatherIconUrl: Decodable {
    let value : String
}
