//
//  TodayViewController.swift
//  PageControl
//
//  Created by Валентина on 28/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController , UIGestureRecognizerDelegate{

    var views = [UIView]()
    var condition1 = false
    var condition2 = false
    var condition3 = false
    @IBOutlet weak var thirdPartTapView: UIView!
    @IBOutlet weak var secondPartTapView: UIView!
    @IBOutlet weak var nowTapView: UIView!
    
    @IBOutlet weak var rainComment: UILabel!
    @IBOutlet weak var windComment: UILabel!
    @IBOutlet weak var commentToday: UILabel!
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var nowTemp: UILabel!
    @IBOutlet weak var nowIcon: UIImageView!
    
    @IBOutlet weak var thirdPartImage: UIImageView!
    @IBOutlet weak var thirdPartTemp: UILabel!
    @IBOutlet weak var thirdPartLabel: UILabel!
    
    @IBOutlet weak var secondPartImage: UIImageView!
    @IBOutlet weak var secondPartTemp: UILabel!
    @IBOutlet weak var secondPartLabel: UILabel!
    
    var month : Month?
    var hour : Int = 0
    var partOfDay : PartsOfDay = .day
    var currentCity = "Moscow"
    var data : Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.views = [self.nowTapView,self.secondPartTapView,self.thirdPartTapView]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.nowTapView.addGestureRecognizer(tap)
        self.secondPartTapView.addGestureRecognizer(tap1)
        self.thirdPartTapView.addGestureRecognizer(tap2)
        self.windComment.adjustsFontForContentSizeCategory = true
        
        getCurrentHour()
        self.commentToday.adjustsFontSizeToFitWidth = true
        self.commentToday.adjustsFontForContentSizeCategory = true
        let jsonUrlString = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=b6a175fdfba04cd2887194127182408&q=\(currentCity)&format=json&num_of_days=7&mca=no&tp=1&quot"
        let url = URL(string: jsonUrlString)
        let task = URLSession.shared.dataTask(with: url!){ (data,
            response, err) in
            do {
                let alldata = try
                    JSONDecoder().decode(Main.self, from: data!)
                self.data = alldata.data
                self.fillInfo(data: self.data!)
//                DispatchQueue.main.async{
//
//           }
            } catch { print("Error deserializing JSON: \(error)")}
        }
        task.resume()
        self.city.text = self.currentCity
        // Do any additional setup after loading the view.
    }

    @objc func handleTap(_ sender : UITapGestureRecognizer) {
        print ("tapped")
        let view = sender.view
        for item in self.views{
            if item != view {
                UIView.animate(withDuration: 0.2, animations: {
//                    item.backgroundColor = .black
                    item.alpha = 0
                }, completion:nil)
            }
            else{
                UIView.animate(withDuration: 0.2, animations: {
                    item.backgroundColor = .black
                item.alpha = 0.1
                }, completion:nil)
            }
        }
       
        
    
    }
    
    func getCurrentHour (){
        let date = Date()
        let calendar = Calendar.current
        self.hour = Int(calendar.component(.hour, from: date))
        switch(self.hour){
        case 0...6 : self.partOfDay = .night
        case 7...12 : self.partOfDay = .morning
        case 13...18 : self.partOfDay = .day
        case 19...24 : self.partOfDay = .evening
        default : return
        }
    }
    
    func fillInfo (data : Data){
//        self.data = alldata.data
        DispatchQueue.main.async{
        self.rainComment.text = rainsExpected(weather: self.data!.weather[0])
        self.commentToday.text = self.Current_Comment(current: self.data!.current_condition[0], weather: self.data!.weather[0])
        self.windComment.text = getWindComment(weather: self.data!.weather[0])
        self.nowTemp.text = self.data!.current_condition[0].FeelsLikeC +  "°C"
        self.nowIcon.image = UIImage(named: self.data!.current_condition[0].weatherCode)
        self.city.text = self.data!.request[0].query!
        switch(self.partOfDay){
        case .morning:
            self.secondPartLabel!.text = "Day"
            self.secondPartTemp.text! = self.data!.weather[0].hourly![15].tempC + "°C"
            
            self.secondPartImage.image = UIImage(named: self.data!.weather[0].hourly![15].weatherCode)
            self.thirdPartLabel!.text = "Evening"
            self.thirdPartTemp.text! = self.data!.weather[0].hourly![21].tempC + "°C"
            self.thirdPartImage.image = UIImage(named: self.data!.weather[0].hourly![21].weatherCode)
        case .day:
            self.secondPartLabel!.text = "Evening"
            self.secondPartTemp.text! = self.data!.weather[0].hourly![21].tempC + "°C"
            self.secondPartImage.image = UIImage(named: self.data!.weather[0].hourly![21].weatherCode)
            self.thirdPartLabel!.text = "Night"
            self.thirdPartTemp.text! = self.data!.weather[1].hourly![3].tempC + "°C"
            self.thirdPartImage.image = UIImage(named: self.data!.weather[1].hourly![3].weatherCode)
        case .evening:
            self.secondPartLabel!.text = "Night"
            self.secondPartTemp.text! = self.data!.weather[1].hourly![3].tempC + "°C"
            self.secondPartImage.image = UIImage(named: self.data!.weather[1].hourly![3].weatherCode)
            self.thirdPartLabel!.text = "Morning"
            self.thirdPartTemp.text! = self.data!.weather[1].hourly![9].tempC + "°C"
            self.thirdPartImage.image = UIImage(named: self.data!.weather[1].hourly![9].weatherCode)
        case .night:
            self.secondPartLabel!.text = "Morning"
            self.secondPartTemp.text! = self.data!.weather[1].hourly![9].tempC + "°C"
            self.secondPartImage.image = UIImage(named: self.data!.weather[1].hourly![9].weatherCode)
            self.thirdPartLabel!.text = "Day"
            self.thirdPartTemp.text! = self.data!.weather[1].hourly![15].tempC + "°C"
            self.thirdPartImage.image = UIImage(named: self.data!.weather[1].hourly![15].weatherCode)
        default : return}
        }
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
    }//no uv yet

}
