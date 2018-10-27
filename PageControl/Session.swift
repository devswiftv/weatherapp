//
//  Session.swift
//  PageControl
//
//  Created by Валентина on 28/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//
//import Alamofire
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

func loadData( currentCity : String, completion : @escaping (Data)->Void){
    let jsonUrlString = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=8af99843b0224966b3a85808182710&q=\(currentCity)&format=json&num_of_days=7&mca=no&tp=1&quot"
    let url = URL(string: jsonUrlString)
    let task = URLSession.shared.dataTask(with: url!){ (data,
        response, err) in
        do {
            let alldata = try
                JSONDecoder().decode(Main.self, from: data!)
            let result = alldata.data
            completion (result)
        } catch { print("Error deserializing JSON: \(error)")}
    }
    task.resume()

}

//let jsonUrlString = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=b6a175fdfba04cd2887194127182408&q=\(currentCity)&format=json&num_of_days=7&mca=no&tp=1&quot"
//let url = URL(string: jsonUrlString)
//let task = URLSession.shared.dataTask(with: url!){ (data,
//    response, err) in
//    do {
//        let alldata = try
//            JSONDecoder().decode(Main.self, from: data!)
//        self.data = alldata.data
//        self.fillInfo(data: self.data!)
//        //                DispatchQueue.main.async{
//        //
//        //           }
//    } catch { print("Error deserializing JSON: \(error)")}
//}
//task.resume()

//func loadUserFriendsAlamofire(completion: @escaping ([FriendVK]) -> Void ){
//    let baseUrl = "https://api.vk.com"
//    let path = "/method/friends.get"
//
//    let params: Parameters = [
//        "access_token": Session.instance.token,
//        "extended": "1",
//        "v": "5.52",
//        "fields":"first_name,photo_50"
//    ]
//    Alamofire.request(baseUrl + path, method: .get, parameters: params).responseData { (response) in
//        guard let data = response.value else {return}
//        print(data)//здесь все ок
//        do {
//            let friends = try JSONDecoder().decode(DataVKFr.self, from: data)
//            //print (friends)
//            let res = friends.response!.items!
//            completion(res)
//        }
//        catch { print(error)}
//    }
//
//}
