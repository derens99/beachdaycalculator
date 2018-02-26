//
//  Endpoint.swift
//  Beach Day Calculator
//
//  Created by Deren Singh on 2/24/18.
//  Copyright © 2018 Deren Singh. All rights reserved.
//

import Foundation

protocol Endpoint{
    var baseUrl: String {get}
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
}

extension Endpoint{
    var urlComponent: URLComponents{
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request : URLRequest{
        return URLRequest(url: urlComponent.url!)
    }
}

enum WeatherEndpoint: Endpoint{
    
    case tenDayForecast(city: String, state: String)
    
    var baseUrl: String{
        return "https://api.wunderground.com"
    }
    
    var path: String{
        switch self{
        case .tenDayForecast(let city, let state):
            return "/api/877210496011db6b/forecast10day/q/\(state)/\(city).json"
        case .conditions(let city, let state):
            return "/api/877210496011db6b/conditions/q/\(state)/\(city).json"
        }
        
        
        
    }
    
    var queryItems: [URLQueryItem]{
        return []
    }
}
