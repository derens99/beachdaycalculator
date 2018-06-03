//
//  Weather.swift
//  Beach Day Calculator
//
//  Created by Deren Singh on 6/2/18.
//  Copyright © 2018 Deren Singh. All rights reserved.
//

import Foundation
import CoreLocation

struct Weather {
    
    let summary:String
    let uvIndex:Double
    let temperature:Double
    let windSpeed: Double
    let cloudCover: Double
    let humidity: Double
    let precipProbability: Double
    let precipType: String
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        guard let uvIndex = json["uvIndex"] as? Double else {throw SerializationError.missing("UV Index is missing")}
        guard let temperature = json["temperature"] as? Double else {throw SerializationError.missing("temp is missing")}
        guard let windSpeed = json["windSpeed"] as? Double else{throw SerializationError.missing("Wind Speed is missing")}
        guard let cloudCover = json["cloudCover"] as? Double else{throw SerializationError.missing("Cloud Cover is missing")}
        guard let humidity = json["humidity"] as? Double else{throw SerializationError.missing("Humidity is missing")}
        guard let precipProbability = json["precipProbability"] as? Double else{throw SerializationError.missing("Humidity is missing")}
        guard let precipType = json["precipType"] as? String else{throw SerializationError.missing("Humidity is missing")}
        
        self.summary = summary
        self.uvIndex = uvIndex
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.cloudCover = cloudCover
        self.humidity = humidity
        self.precipProbability = precipProbability
        self.precipType = precipType
    }
    
    
    static let basePath = "https://api.darksky.net/forecast/1be0b7eb318d56e76829d62f96130e23/"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
        
    }
    
    static func hourlyForecast(withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()){
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        print(url)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let hourlyForecasts = json["hourly"] as? [String:Any] {
                            if let hourlyData = hourlyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in hourlyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
    }
    
    
}
