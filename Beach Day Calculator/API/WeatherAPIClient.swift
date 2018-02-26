//
//  WeatherAPIClient.swift
//  Beach Day Calculator
//
//  Created by Deren Singh on 2/25/18.
//  Copyright © 2018 Deren Singh. All rights reserved.
//

import Foundation

class WeatherApiClient: APIClient{
    var session: URLSession
    
    //Init with a default value
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Either<ForecastText, APIError>) -> Void){
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either{
            case .value(let weather):
                let textForecast = weather.forecast.forecastText
                completion(.value(textForecast))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
