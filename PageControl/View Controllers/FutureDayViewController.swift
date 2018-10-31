//
//  FutureDayViewController.swift
//  PageControl
//
//  Created by Валентина on 28/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import UIKit

class FutureDayViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var thirdPartLabel: UILabel!
    @IBOutlet weak var secondPartLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
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
    static var status = false
    static var data : Data?
//    var  indexOfDay = 0
    var currentCity = ""
    static var counter : Int = 0
    
    override func viewDidLoad() {
        self.createRecognizer()
        super.viewDidLoad()
        self.layoutLabels()
        print(FutureDayViewController.counter)
        if FutureDayViewController.status == false{
            loadData(currentCity: self.currentCity, completion:
                        { [weak self] alldata in
                                FutureDayViewController.data = alldata
//                                self!.fullFillInfo()
                            self?.fullFillTodayInfo()
                            
                    })
//            FutureDayViewController.status = true
        } else {
            self.fullFillInfo()
        }
    }
    @objc func handleSwipe(_ gesture: UIGestureRecognizer) {
        print("swiped")
        self.dismiss(animated: true, completion: nil)
        FutureDayViewController.counter = 0
        FutureDayViewController.status = false
    }
    func createRecognizer (){
        let recogniser = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        recogniser.direction = .down
        self.view.addGestureRecognizer(recogniser)
        
    }
    func fullFillInfo (){
                DispatchQueue.main.async{
        self.rainComment.text = rainsExpected(weather: FutureDayViewController.data!.weather[FutureDayViewController.counter])
        self.windComment.text = getWindComment(weather: FutureDayViewController.data!.weather[FutureDayViewController.counter])
        self.comment.text = CommentForFutureDay(weather: FutureDayViewController.data!.weather[FutureDayViewController.counter])
        self.date.text = FutureDayViewController.data!.weather[FutureDayViewController.counter].date!
        self.cityLabel.text = FutureDayViewController.data!.request[0].query!
        self.morningTemp.text = FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![9].tempC + "°C"
        self.morningImage.image = UIImage(named: FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![9].weatherCode)
        self.dayTemp.text = FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![15].tempC + "°C"
        self.dayImage.image = UIImage(named: FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![15].weatherCode)
        self.eveningTemp.text = FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![21].tempC + "°C"
        self.eveningImage.image = UIImage(named: FutureDayViewController.data!.weather[FutureDayViewController.counter].hourly![21].weatherCode)
                    FutureDayViewController.counter += 1
                    FutureDayViewController.status = true
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
        let nowLabel = UILabel()
        let secondPartLabel = UILabel()
        let thirdPartLabel = UILabel()
        
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
        self.view.addSubview(nowLabel)
        self.view.addSubview(secondPartLabel)
        self.view.addSubview(thirdPartLabel)

        nowLabel.translatesAutoresizingMaskIntoConstraints = false
        nowLabel.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 274).isActive = true
        nowLabel.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 135).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        nowLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        nowLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        nowLabel.textAlignment = .center
        nowLabel.font = UIFont(name: label.font.fontName, size: 22)
        self.nowLabel = nowLabel
        
        secondPartLabel.translatesAutoresizingMaskIntoConstraints = false
        secondPartLabel.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 274).isActive = true
        secondPartLabel.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 257).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        secondPartLabel.widthAnchor.constraint(equalToConstant: 114).isActive = true
        secondPartLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        secondPartLabel.textAlignment = .center
        secondPartLabel.font = UIFont(name: label.font.fontName, size: 22)
        self.secondPartLabel = secondPartLabel
        
        thirdPartLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdPartLabel.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 276).isActive = true
        thirdPartLabel.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 374).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        thirdPartLabel.widthAnchor.constraint(equalToConstant: 114).isActive = true
        thirdPartLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        thirdPartLabel.textAlignment = .center
        thirdPartLabel.font = UIFont(name: label.font.fontName, size: 22)
        self.thirdPartLabel = thirdPartLabel
        
        
        date.translatesAutoresizingMaskIntoConstraints = false
        date.centerXAnchor.constraint(equalTo: self.view!.leftAnchor, constant: 185.0).isActive = true
        date.centerYAnchor.constraint(equalTo: self.view!.topAnchor, constant: 41.0).isActive = true
        //        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        date.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
    func fullFillTodayInfo (){
            let part = getCurrentHour()
        DispatchQueue.main.async {
            self.date.text = FutureDayViewController.data!.weather[FutureDayViewController.counter].date!
            self.cityLabel.text = FutureDayViewController.data!.request[0].query!
            self.rainComment.text = rainsExpected(weather: FutureDayViewController.data!.weather[0])
            self.comment.text = Current_Comment(current: FutureDayViewController.data!.current_condition[0], weather: FutureDayViewController.data!.weather[0])
            self.windComment.text = getWindComment(weather: FutureDayViewController.data!.weather[0])
            self.nowLabel.text = "Now"
            self.morningTemp.text = FutureDayViewController.data!.current_condition[0].temp_C + "°C"
            self.morningImage.image = UIImage(named: FutureDayViewController.data!.current_condition[0].weatherCode)
            switch(part){
                case .morning:
                self.secondPartLabel!.text = "Day"
                self.dayTemp.text = (FutureDayViewController.data?.weather[0].hourly![15].tempC)! + "°C"
                self.dayImage.image = UIImage(named: (FutureDayViewController.data?.weather[0].hourly![15].weatherCode)!)
                self.thirdPartLabel.text = "Evening"
                self.eveningTemp.text = (FutureDayViewController.data?.weather[0].hourly![21].tempC)! + "°C"
                self.eveningImage.image = UIImage(named: (FutureDayViewController.data?.weather[0].hourly![21].weatherCode)!)
            case .day:
                self.secondPartLabel!.text = "Evening"
                self.dayTemp.text = (FutureDayViewController.data?.weather[0].hourly![21].tempC)! + "°C"
                self.dayImage.image = UIImage(named: (FutureDayViewController.data?.weather[0].hourly![21].weatherCode)!)
                self.thirdPartLabel.text = "Night"
                self.eveningTemp.text = (FutureDayViewController.data?.weather[1].hourly![3].tempC)! + "°C"
                self.eveningImage.image = UIImage(named: (FutureDayViewController.data?.weather[1].hourly![3].weatherCode)!)
            case .evening:
                self.secondPartLabel!.text = "Night"
                self.dayTemp.text = (FutureDayViewController.data?.weather[1].hourly![3].tempC)! + "°C"
                self.dayImage.image = UIImage(named: (FutureDayViewController.data?.weather[1].hourly![3].weatherCode)!)
                self.thirdPartLabel.text = "Morning"
                self.eveningTemp.text = (FutureDayViewController.data?.weather[1].hourly![9].tempC)! + "°C"
                self.eveningImage.image = UIImage(named: (FutureDayViewController.data?.weather[1].hourly![9].weatherCode)!)
            case .night:
                self.secondPartLabel!.text = "Morning"
                self.dayTemp.text = (FutureDayViewController.data?.weather[1].hourly![9].tempC)! + "°C"
                self.dayImage.image = UIImage(named: (FutureDayViewController.data?.weather[1].hourly![9].weatherCode)!)
                self.thirdPartLabel.text = "Day"
                self.eveningTemp.text = (FutureDayViewController.data?.weather[1].hourly![15].tempC)! + "°C"
                self.eveningImage.image = UIImage(named: (FutureDayViewController.data?.weather[1].hourly![15].weatherCode)!)
            }
            FutureDayViewController.counter += 1
            FutureDayViewController.status = true
        }
    }
    
    
}
