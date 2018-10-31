//
//  Helpers.swift
//  PageControl
//
//  Created by Валентина on 30/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import Foundation

enum Condition {
    case selected, notselected
}
enum Month : Int {
    case January = 1
    case  February = 2
    case March  = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
}

func probabilityOfThunder (weather : Weather)->Bool{
    let thunders = weather.hourly?.contains(where: {Int($0.chanceofthunder)! > 50})
    return thunders!
}
func rainsExpected(weather : Weather)->String{
    var text = "No rains expected"
    for item in weather.hourly!{
        if (Int(item.chanceofrain)! >= 50 || Int(item.chanceofthunder)! > 50){
            return "Rains expected"
        }
        else if (Int(item.chanceofsnow)! >= 50){
            return "Snow expected"
        }
    }
    return text
}

func getWindComment(weather : Weather)->String{
    var flag = 0
    var condition = "Calm"
    for item in weather.hourly!{
        if (Int(item.windspeedKmph)! > 4){
            condition = "Light breeze"
        }
        else if (Int(item.windspeedKmph)! > 19){
            condition = "Fresh breeze"
        }
        else if (Int(item.windspeedKmph)! > 32){
            condition = "Mind strong wind!"
        }
        else if (Int(item.windspeedKmph)! > 55){
            condition = "Mind the storm!"
        }
    }
    return condition
}

func getCurrentHour ()-> PartsOfDay{
    let date = Date()
    let calendar = Calendar.current
    let hour = Int(calendar.component(.hour, from: date))
    switch(hour){
    case 0...6 :  return .night
    case 7...12 : return .morning
    case 13...18 : return .day
    case 19...24 : return .evening
    default : return .day
    }
}

func ProbabilityOfRainOrSnow (someHours : [Hourly])->(Bool, String?){
    let rainOrSnow = false
    for index in 0...5
    {
        if (!rainOrSnow)
        {
            if (Int(someHours[index].chanceofrain)! > 50)
            {return (true, "rain")}
            else if (Int(someHours[index].chanceofsnow)! > 50)
            {return (true,"snow")}
        }
    }
    return (false, nil)
}

func AverageForParts (someHours : [Hourly])->(Double){
    var average : Double = 0.0
    for index in 0...5
    {
        average += Double(someHours[index].FeelsLikeC)!
    }
    average = average/6
    return average
}

