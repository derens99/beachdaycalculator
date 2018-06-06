//
//  ViewController.swift
//  Beach Day Calculator
//
//  Created by Deren Singh on 2/19/18.
//  Copyright © 2018 Deren Singh. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController, UISearchBarDelegate, GMSAutocompleteViewControllerDelegate{
    
    var selectedLocation: GMSPlace!
    var forecastData = [Weather]()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    func updateWeather(location: GMSPlace) -> [Weather]{
        var data = [Weather]()
        Weather.hourlyForecast(withLocation: location.coordinate, completion: { (results:[Weather]?) in
            if let weatherData = results {
                self.forecastData = weatherData
            }
            data = results!
        })
        return data
    }
    
    //Autocomplete Deletegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedLocation = place
        searchBar.text = selectedLocation.name
        
        //This happens way after everthing else. how do i fix?
        Weather.hourlyForecast(withLocation: place.coordinate, completion: { (results:[Weather]?) in
            if let weatherData = results{
                DispatchQueue.main.async {
                    self.forecastData = weatherData
                    self.tempLabel.text = self.forecastData[0].summary
                }
            }
        })
        
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Failed with error \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

