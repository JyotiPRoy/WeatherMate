//
//  CurrentWeather.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 26/11/21.
//

import Foundation
import SwiftyJSON

class CurrentWeather {
    
    fileprivate var _cityName: String!
    fileprivate var _countryCode: String!
    fileprivate var _currentTemp: Int!
    fileprivate var _feelsLikeTemp: Int!
    fileprivate var _humidity: Int!
    fileprivate var _weatherCondition: String!
    
    var cityName: String {
        get {
            return _cityName
        } set {
            _cityName = newValue
        }
    }
    
    var countryCode: String {
        get {
            return _countryCode
        } set {
            _countryCode = newValue
        }
    }
    
    var currentTemp: Int {
        get {
            return _currentTemp
        } set {
            _currentTemp = newValue
        }
    }

    var feelsLikeTemp: Int {
        get {
            return _feelsLikeTemp
        } set {
            _feelsLikeTemp = newValue
        }
    }
    
    var humidity: Int {
        get {
            return _humidity
        } set {
            _humidity = newValue
        }
    }
    
    var weatherCondition: String {
        get {
            return _weatherCondition
        } set {
            _weatherCondition = newValue
        }
    }
    
    class func fromData(_ APIData: Data) -> CurrentWeather {
        let currentWeather = CurrentWeather()
        do {
            let swiftyJson = try JSON(data: APIData)
            
            currentWeather.cityName = swiftyJson["name"].stringValue
            currentWeather.countryCode = swiftyJson["sys"]["country"].stringValue
            currentWeather.currentTemp = swiftyJson["main"]["temp"].intValue
            currentWeather.feelsLikeTemp = swiftyJson["main"]["feels_like"].intValue
            currentWeather.humidity = swiftyJson["main"]["humidity"].intValue
            currentWeather.weatherCondition = swiftyJson["weather"][0]["main"].stringValue
            
        }catch let error as NSError {
            print("ERROR: \(error)")
        }
        return currentWeather
    }
    
    func toString() -> String {
        return """
        Current Weather:
        Temperature: \(currentTemp)
        Feels Like: \(feelsLikeTemp)
        Humidity: \(humidity)
        Weather Condition: \(weatherCondition)
        Location: \(cityName), \(countryCode)
        """
    }
}
