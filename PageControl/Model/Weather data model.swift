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

func Current_Comment (current : Current_condition, weather : Weather)->String{
    var comment : String = ""
    let tempfeelslike = Int(current.FeelsLikeC)
    switch (tempfeelslike!){
    case -50 ..< -30:
        comment += "Extremely cold. Avoid being outside unless dressed properly! "
    case -30 ..< -10:
        comment += "Very cold. Dress warmly! "
    case -10 ..< -5:
        comment += "Frosty weather, put on your coat, scarf and gloves. "
    case -5 ..< -3:
        comment += "Frosty weather, put on your coat. "
    case -2 ..< 0:
        comment += "Mind the freezing, put on your coat. "
    case 0..<3:
        comment += "Mind the freezing! Stay warm, put on a coat. "
    case 3..<7:
        comment += "Quite cool, put on a coat. "
    case 7..<13:
        comment += "Comfortable weather, put on a jacket. "
    case 13..<18:
        comment += "Quite warm, put on a hoodie and jeans. "
    case 18..<20:
        comment += "Warm weather, put on a longsleeve and jeans. "
    case 20..<23:
        comment += "Comfortable warm weather, put on shirt. "
    case 23..<25:
        comment += "Feels warm, put on a t-shirt and jeans. "
    case 25..<35:
        comment += "It's hot outside, better put on a t-shirt and shorts. "
    case 30..<50:
        comment += "Extremely hot! Put on the lightest clothes. "
    default:
        comment = "There is no comment " }
    let temp = Int(current.temp_C)
    switch (temp!){
    case -1..<10:
        let wind = Double(current.windspeedKmph)
        switch (wind!*5/18)
        {
        case 0..<4.5:
            comment += "Feels slightly cooler than it seems. "
        case 4.5..<10:
            comment += "Feels cooler than it seems. "
        default:
            comment += "Feels considerably colder than it seems. "
        }
    default:
        comment += ""
    }
    let wind = Double(current.windspeedKmph)
    switch(wind!*5/18){
    case 7...9:
        comment += "Mind strong wind! "
    case 9...20:
        comment += "Mind very strong wind! "
    case 20...50:
        comment += "Extremely strong wind! "
    default: comment += ""
    }
    var thunderflag = false
    for item in weather.hourly! {
        if (Int(item.chanceofthunder)! > 50 )
        { thunderflag = true
            comment += "Thunders are possible. "
            break}
    }
    if (thunderflag == false){
        for hour in weather.hourly! {
            if (Int(hour.chanceofrain)! > 50 )
            { comment += "Rains are possible. "
                break}
        }
    }
    print ("Feels like: "+weather.hourly![12].FeelsLikeC)
    return comment
}


func CommentForFutureDay (weather : Weather)->String{ //
    var comment = ""
    let night = Array(weather.hourly![0..<6])
    let morning = Array(weather.hourly![6..<12])
    let day = Array(weather.hourly![12..<18])
    let evening = Array(weather.hourly![18..<24])
    //temperarure and clothes
    var avgtemp = 0 //for whole day
    for index in 0...23
    {avgtemp += Int(weather.hourly![index].tempC)!}
    avgtemp = avgtemp/24 //for the whole day
    //print (avgtemp)
    let avgNight = lroundf(Float(AverageForParts(someHours: night)))
    let avgMorning = lroundf(Float(AverageForParts(someHours: morning)))
    let avgDay = lroundf(Float(AverageForParts(someHours: day)))
    let avgEvening = lroundf(Float(AverageForParts(someHours: evening)))
    switch avgtemp
    {
    case -70 ..< -30 :
        comment += "Extremely cold! Avoid being outside unless dressed up properly! "
        
    case -30 ..< -10:
        comment += "Very cold weather. Put on all the warmes clothes and don't say outside for too much. "
        
    case -10 ..< -5:
        comment +=  "Cold frosty weather. Put on a winter coat, scarf and gloves. "
        
    case -5 ..< -3:
        comment +=  "Feels cold and freezing. Put on a coat and a cap. "
        
    case -3 ..< 0:
        comment += "Freezing weather. Dress warmly, put on a coat and probably a cap. "
        
    case 0..<3 where Int(weather.hourly![12].humidity)!>70:
        comment += "Freezing and humid weather. Put on a coat, gloves and a scarf.  "
        
    case 0..<3 :
        comment += "Freezing and humid weather. Put on a coat and jeans. "
        
    case 3..<7 where Int(weather.hourly![12].humidity)!>70:
        comment += "Feels cool and humid. Put on a coat and probably a scarf. "
        
    case 3..<7:
        comment += "Feels cool, put on a jacket and jeans. "
        
    case 7..<13:
        comment += "Comfortable cool weather. Put on a jacket and jeans. "
        
    case 13..<18:
        if (Int(weather.hourly![12].humidity)! > 70){
            comment += "Quite cool, probably put on a hoodie and jeans."
        } else {
            comment += "Feels warm, probably put on a hoodie and jeans. "}
    case 18..<20:
        comment += "Feels warm, probably put on a longsleeve and jeans. "
        
    case 20..<23:
        comment += "Feels warm, probably put on a shirt and jeans. "
        
    case 23..<25:
        comment += "Comfortable warm weather. Put on a T-shirt and jeans. "
        
    case  25..<35:
        if (avgtemp > 29) && (Int(weather.hourly![12].humidity)! > 70)
        {
            comment += "Very hot outside. Mind dehydration! Put on a t-shirt and shorts. "
        }
        else { comment += "Feels hot. Put on a t-shirt and shorts. "}
    case 35..<43:
        if (Int(weather.hourly![12].humidity)!>30)
        {
            comment += "Enormously hot, might be unbearable. Avoid being outside for too long! Don't wear dark colors. "
        }
        else { comment += "Extremely hot. Be careful and avoid the sunlight. Don't wear dark colors. "}
        
    case 43..<100:
        comment += "Enormously hot. Mind the risk of a sunstroke. Avoid being outside! Put on the lighest clothes. "
        
    default:
        comment = "There is no comment "
    }
    //considerably cooler or warmer
    if (Int(weather.maxtempC!)!-Int(weather.mintempC!)! > 10)
    { comment += "Considerable temperarure difference during the day. " }
    //rain and snow
    let allBools = [ProbabilityOfRainOrSnow(someHours: night).0,ProbabilityOfRainOrSnow(someHours: morning).0,ProbabilityOfRainOrSnow(someHours: day).0,ProbabilityOfRainOrSnow(someHours: evening).0]
    let allTypesOfPr = [ProbabilityOfRainOrSnow(someHours: night).1,ProbabilityOfRainOrSnow(someHours: morning).1,ProbabilityOfRainOrSnow(someHours: day).1,ProbabilityOfRainOrSnow(someHours: evening).1]
    if (allTypesOfPr.contains("snow"))
    {comment += "Snowfall is possible. "}
    else {
        switch (allBools){
        case [false,false,false,false]: break
        case [true,true,true,true] : comment += "Rains during all the day are possible. "
        case [false,true,true,true] : comment += "Rains during all the day are possible. "
        case [false,true,true,false] : comment += "Rains in the first part of the day are possible. "
        case [true,true,true,false] : comment += "Rains in the first part of the day are possible. "
        case [false,false,true,true] : comment += "Rains in the second part of the day are possible. "
        case [true,false,true,true] : comment += "Rains in the second part of the day are possible. "
        case [false,true,false,true] : comment += "Morning and evening rains are possible. "
        case [true,true,false,true] : comment += "Morning and evening rains are possible. "
        case [false,true,false,false] : comment += "Rains are possible in the morning. "
        case [true,true,false,false] : comment += "Rains are possible in the morning. "
        case [false,false,true,false] : comment += "Rains are possible in the afternoon. "
        case [true,false,true,false] : comment += "Rains are possible in the afternoon. "
        case [false,false,false,true] : comment += "Rains are possible in the evening. "
        case [true,false,false,true] : comment += "Rains are possible in the evening. "
        case [true,false,false,false] : comment += "Rains are possible in the night. "
        default : comment += ""
        }}
    if (probabilityOfThunder(weather: weather)) {comment += "Mind thunders. "}
    var maxwind = 0
    for index in 0...23{
        if (Int(weather.hourly![index].windspeedKmph)! > maxwind)
        {maxwind = Int(weather.hourly![index].windspeedKmph)!}
    }
    maxwind = maxwind*5/18 //meters per second
    
    switch(maxwind){
    case 7...9:
        comment += "Mind strong wind! "
    case 9...20:
        comment += "Mind very strong wind! "
    case 20...50:
        comment += "Extremely strong wind! "
    default: comment += ""
    switch ((Int(weather.uvIndex!))!){
    case 7..<9 : comment += "Mind high UV index."
    case 9..<12 : comment += "Mind very high UV index, don't forget about sun protection!"
    case 12..<50: comment += "Mind extremely high UV index! Avoid being outside. "
    default : comment += ""
        }
    }
    return comment
}
