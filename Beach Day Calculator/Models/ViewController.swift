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

class ViewController: UIViewController, UISearchBarDelegate, GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate{
    
    var selectedLocation: GMSPlace!
    
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
    
    func getWeather(){
        
    }
    
    func calculateBeachDay() -> Float{
        return 0.1
    }
    
    
    //Autocomplete Deletegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedLocation = place
        searchBar.text = selectedLocation.name
        
        
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Failed with error \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
