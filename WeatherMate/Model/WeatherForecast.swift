//
//  WeatherForecast.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 28/11/21.
//

import Foundation
import SwiftyJSON

class WeatherForecast {
    
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    
    var date: String {
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    
    class func loadDataAsync(_ APIData: Data, completed: @escaping ( ([Int], [WeatherForecast]) -> () )) {
        var forecasts = [WeatherForecast]()
        var highLowToday = [Int]()
        do {
            let json = try JSON(data: APIData)
            
            if let list = json["daily"].array {
                for i in 0..<(list.count) {
                    let rawForecast = list[i]
                    if(i == 0) {
                        highLowToday = [
                            rawForecast["temp"]["max"].intValue,
                            rawForecast["temp"]["min"].intValue
                        ]
                    }else {
                        let forecast = WeatherForecast()
                        
                        let epochTime = TimeInterval(rawForecast["dt"].intValue)
                        let date = Date(timeIntervalSince1970: epochTime)
                        forecast.date = date.dayOfWeek()
                        forecast.weatherType = rawForecast["weather"][0]["main"].stringValue
                        
                        print("DATE: \(forecast.date)")
                        
                        forecasts.append(forecast)
                    }
                }
            }
            completed(highLowToday, forecasts)
        }catch let error as NSError {
            print("ERROR: \(error))")
        }
    }
}
