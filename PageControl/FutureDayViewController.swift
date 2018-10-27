//
//  FutureDayViewController.swift
//  PageControl
//
//  Created by Валентина on 28/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import UIKit

class FutureDayViewController: UIViewController {

    @IBOutlet weak var windComment: UILabel!
    @IBOutlet weak var rainComment: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var eveningImage: UIImageView!
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var morningImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var morningTemp: UILabel!
    @IBOutlet weak var eveningTemp: UILabel!
    @IBOutlet weak var dayTemp: UILabel!
    var month : Month?
    var data : Data?
    var indexOfDay = 0
    var currentCity = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutLabels()
        loadData(currentCity: self.currentCity, completion:
            { [weak self] alldata in
                self!.fullFillInfo(data: alldata)
                self?.data = alldata
        })
        print(indexOfDay)
    }
    func fullFillInfo (data : Data){
                DispatchQueue.main.async{
        self.rainComment.text = rainsExpected(weather: data.weather[self.indexOfDay])
        self.windComment.text = getWindComment(weather: data.weather[self.indexOfDay])
        self.comment.text = self.CommentForFutureDay(weather: data.weather[self.indexOfDay])
        self.date.text = data.weather[self.indexOfDay].date!
        self.cityLabel.text = data.request[0].query!
        self.morningTemp.text = data.weather[self.indexOfDay].hourly![9].tempC + "°C"
        self.morningImage.image = UIImage(named: data.weather[self.indexOfDay].hourly![9].weatherCode)
        self.dayTemp.text = data.weather[self.indexOfDay].hourly![15].tempC + "°C"
        self.dayImage.image = UIImage(named: data.weather[self.indexOfDay].hourly![15].weatherCode)
        self.eveningTemp.text = data.weather[self.indexOfDay].hourly![21].tempC + "°C"
        self.eveningImage.image = UIImage(named: data.weather[self.indexOfDay].hourly![21].weatherCode)
        }
    }
    func layoutLabels(){ //fillable elements created programmatically
        let date = UILabel()
        let label = UILabel()
        let labelmorning = UILabel()
        let labelday = UILabel()
        let labelevening = UILabel()
        let imagemorning = UIImageView()
        let imageday = UIImageView()
        let imageevening = UIImageView()
        let commentLabel = UILabel()
        let rainComment = UILabel()
        let windComment = UILabel()
        
        self.view.addSubview(labelmorning)
        self.view.addSubview(labelday)
        self.view.addSubview(labelevening)
        self.view.addSubview(label)
        self.view.addSubview(date)
        self.view.addSubview(imageday)
        self.view.addSubview(imageevening)
        self.view.addSubview(imagemorning)
        self.view.addSubview(commentLabel)
        self.view.addSubview(rainComment)
        self.view.addSubview(windComment)

        date.translatesAutoresizingMaskIntoConstraints = false
        date.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 185.0).isActive = true
        date.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 41.0).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        date.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        date.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        date.textAlignment = .center
        date.font = UIFont(name: label.font.fontName, size: 19)
        self.date = date
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 185.0).isActive = true
        commentLabel.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 595.0).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        commentLabel.widthAnchor.constraint(equalToConstant: 341.0).isActive = true
        commentLabel.heightAnchor.constraint(equalToConstant: 81.0).isActive = true
        commentLabel.textAlignment = .center
//        commentLabel.font = UIFont(name: label.font.fontName, size: 22)
        commentLabel.numberOfLines = 6
        commentLabel.adjustsFontSizeToFitWidth = true
        commentLabel.adjustsFontForContentSizeCategory = true
        self.comment = commentLabel
        
        rainComment.translatesAutoresizingMaskIntoConstraints = false
        rainComment.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 282.0).isActive = true
        rainComment.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 487.5).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        rainComment.widthAnchor.constraint(equalToConstant: 224).isActive = true
        rainComment.heightAnchor.constraint(equalToConstant: 21).isActive = true
        rainComment.textAlignment = .center
        rainComment.font = UIFont(name: label.font.fontName, size: 20)
        rainComment.numberOfLines = 1
        rainComment.adjustsFontSizeToFitWidth = true
        rainComment.adjustsFontForContentSizeCategory = true
        self.rainComment = rainComment
        
        windComment.translatesAutoresizingMaskIntoConstraints = false
        windComment.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 287.5).isActive = true
        windComment.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 530.0).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        windComment.widthAnchor.constraint(equalToConstant: 224).isActive = true
        windComment.heightAnchor.constraint(equalToConstant: 21).isActive = true
        windComment.textAlignment = .center
        windComment.font = UIFont(name: label.font.fontName, size: 20)
        windComment.numberOfLines = 1
        windComment.adjustsFontSizeToFitWidth = true
        windComment.adjustsFontForContentSizeCategory = true
        self.windComment = windComment

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 185.0).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 67.5).isActive = true
//        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 20)
        self.cityLabel = label
        
        labelmorning.translatesAutoresizingMaskIntoConstraints = false
        //        self.morningTemp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 225.0).isActive = true
         labelmorning.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 142.5).isActive = true
        labelmorning.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 250.0).isActive = true
        labelmorning.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        labelmorning.widthAnchor.constraint(equalToConstant: 73.0).isActive = true
        labelmorning.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        labelmorning.textAlignment = .center
        labelmorning.font = UIFont(name: label.font.fontName, size: 27)
        self.morningTemp = labelmorning
        
        imagemorning.translatesAutoresizingMaskIntoConstraints = false
        //        self.morningTemp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 225.0).isActive = true
        imagemorning.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 142.5).isActive = true
        imagemorning.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 315.0).isActive = true
        imagemorning.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        imagemorning.widthAnchor.constraint(equalToConstant: 52.0).isActive = true
        imagemorning.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        self.morningImage = imagemorning
        
       
        
        imageevening.translatesAutoresizingMaskIntoConstraints = false
        //        self.morningTemp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 225.0).isActive = true
        imageevening.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 421.0).isActive = true
        imageevening.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 315.0).isActive = true
//        imageevening.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        imageevening.widthAnchor.constraint(equalToConstant: 52.0).isActive = true
        imageevening.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        self.eveningImage = imageevening
        
        labelday.translatesAutoresizingMaskIntoConstraints = false
        labelday.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 305.0).isActive = true
        labelday.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 250.0).isActive = true
        labelday.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        labelday.widthAnchor.constraint(equalToConstant: 73.0).isActive = true
        labelday.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        labelday.textAlignment = .center
        labelday.font = UIFont(name: label.font.fontName, size: 27)
        
        imageday.translatesAutoresizingMaskIntoConstraints = false
        //        self.morningTemp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 225.0).isActive = true
        imageday.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 305.0).isActive = true
        imageday.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 315.0).isActive = true
        //        imageday.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        imageday.widthAnchor.constraint(equalToConstant: 52.0).isActive = true
        imageday.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        self.dayImage = imageday

        self.dayTemp = labelday
        labelevening.translatesAutoresizingMaskIntoConstraints = false
        labelevening.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 421.0).isActive = true
        labelevening.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 250.0).isActive = true
        labelevening.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
        labelevening.widthAnchor.constraint(equalToConstant: 73.0).isActive = true
        labelevening.heightAnchor.constraint(equalToConstant: 54.0).isActive = true
        labelevening.textAlignment = .center
        labelevening.font = UIFont(name: label.font.fontName, size: 27)
        self.eveningTemp = labelevening
        
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
        print (avgNight)
        print (avgDay)
        
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
}
