//
//  SearchTableViewController.swift
//  PageControl
//
//  Created by Валентина on 03/10/2018.
//  Copyright © 2018 Seemu. All rights reserved.
//
import GooglePlaces
import UIKit

class SearchTableViewController: UITableViewController,UISearchBarDelegate {
    var cities = [String]()
    var typedCity = ""
    @IBOutlet weak var searchCity: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCity.delegate = self
        if (UserDefaults.standard.array(forKey: "SearchHistory") != nil){
            self.cities =  UserDefaults.standard.array(forKey: "SearchHistory") as! [String]}
        else {self.cities = [String]()}
        print (self.cities)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.cities.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell city", for: indexPath)


        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("changed")
    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.typedCity = self.searchCity.text!
        if !(self.cities.contains(self.typedCity)){
            self.cities.append(self.typedCity)
        }
        UserDefaults.standard.set(self.cities, forKey: "SearchHistory")
        performSegue(withIdentifier: "goToForecast", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "goToForecast"{
            let nextVC:PageViewController = segue.destination as! PageViewController
            nextVC.typedCity = self.typedCity
            (nextVC.orderedViewControllers[0] as! TodayViewController).currentCity = self.typedCity
            
        }
    }
}
