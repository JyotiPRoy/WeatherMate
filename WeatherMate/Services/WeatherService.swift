//
//  WeatherService.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 26/11/21.
//

import Foundation
import Alamofire
class WeatherService {
    
    static let instance = WeatherService()
    
    func getWeatherDetails() {
        let url = URL(string: API_CURRENT_WEATHER_URL)
        AF.request(url!).responseJSON { (response) in
            print("RESPONSE: \n \(response.result)")
        }
    }
}
