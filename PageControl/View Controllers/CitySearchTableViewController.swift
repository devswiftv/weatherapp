//
//  CitySearchTableViewController.swift
//  PageControl
//
//  Created by Валентина on 30/10/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//

import UIKit

class CitySearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var cities = [String]()
    var typedCity = ""
    @IBOutlet weak var searchCity: UISearchBar!
    @IBOutlet var citiesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.citiesTableView.reloadData()
        self.citiesTableView.delegate = self
        self.citiesTableView.dataSource = self
        self.searchCity.delegate = self
        self.citiesTableView.reloadData()
        
        if (UserDefaults.standard.value(forKey: "CitySearch") != nil){
        self.cities = UserDefaults.standard.value(forKey: "CitySearch") as! [String]
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = self.cities[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (UserDefaults.standard.value(forKey: "CitySearch") != nil){
            self.cities = UserDefaults.standard.value(forKey: "CitySearch") as! [String]
        }
                return self.cities.count
            }
    
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                print("changed")
            }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                self.typedCity = self.searchCity.text!
                if !(self.cities.contains(self.typedCity)){
                    self.cities.append(self.typedCity)
                }
                UserDefaults.standard.set(self.cities, forKey: "CitySearch")
                performSegue(withIdentifier: "goToForecast", sender: nil)
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier! == "goToForecast"{
                    let nextVC:PageViewController = segue.destination as! PageViewController
                    nextVC.orderedViewControllers.map{($0 as! FutureDayViewController).currentCity = self.typedCity}
               
                }
}//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.typedCity = self.cities[indexPath.row]
        performSegue(withIdentifier: "goToForecast", sender: nil)
    }
}
