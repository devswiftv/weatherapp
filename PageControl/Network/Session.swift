//
//  Session.swift
//  PageControl
//
//  Created by Валентина on 28/09/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//
//import Alamofire
import Foundation

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
