//
//  ViewController.swift
//  Beach Day Calculator
//
//  Created by Deren Singh on 2/19/18.
//  Copyright © 2018 Deren Singh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, UISearchBarDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate{
    
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
        print("Search bar was clicked")
        
    }
    
    
    func calculateBeachDay() -> Float{
        return 0.1
    }
    
    
    //Autocomplete Deletegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedLocation = place
        searchBar.text = selectedLocation.name
        
        print(selectedLocation.coordinate.latitude)
        print(selectedLocation.coordinate.longitude)
        
        print(selectedLocation.name)
        
        
        Weather.hourlyForecast(withLocation: self.selectedLocation.coordinate, completion: { (results:[Weather]?) in
            if let weatherData = results{
                self.forecastData = weatherData
                print("Weather data")
                print(weatherData.count)
                
            }
            print(results?.count)
        })
        
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        self.tempLabel.text = forecastData[0].summary
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Failed with error \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
