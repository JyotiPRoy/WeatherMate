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
    
    fileprivate var _currentWeather: CurrentWeather!
    var currentWeather: CurrentWeather {
        get {
            return _currentWeather
        } set {
            _currentWeather = newValue
        }
    }
    
    // Not a clean way to do things, but I'm not gonna put too much
    // r&d into such a simple project.
    fileprivate var _highLowToday: [Int] = [0,0]
    var highLowToday: [Int] {
        get{
            return _highLowToday
        } set {
            _highLowToday = newValue
        }
    }
    
    fileprivate var _weatherForecasts: [WeatherForecast]!
    var weatherForecasts: [WeatherForecast] {
        get{
            return _weatherForecasts
        } set {
            _weatherForecasts = newValue
        }
    }
    
    private func _getCurrentWeatherUrl(fetchOptions: WeatherFetchOptions) -> String {
        var url: String = API_CURRENT_WEATHER_BASE_URL
        
        //TODO: Fetch User loaction. Also load user's unit preference from CoreData
        
        url += "lat=\(fetchOptions.latitude!)"
            + "&lon=\(fetchOptions.longitude!)"
            + "&units=\(fetchOptions.unit.rawValue)"
            + "&appid=\(OPENWEATHER_API_KEY)"

        return url
    }
    
    private func _getOneCallUrl(fetchOptions: WeatherFetchOptions) -> String {
        var url: String = API_ONECALL_BASE_URL
        
        //TODO: Fetch User loaction. Also load user's unit preference from CoreData
        
        url += "lat=\(fetchOptions.latitude!)"
            + "&lon=\(fetchOptions.longitude!)"
            + "&exclude=\(fetchOptions.getExcludeAsString())"
            + "&units=\(fetchOptions.unit.rawValue)"
            + "&appid=\(OPENWEATHER_API_KEY)"

        return url
    }
    
    func getWeatherDetails(completed: @escaping DownloadComplete) {
        let url = URL(string: _getCurrentWeatherUrl(
            fetchOptions: WeatherFetchOptions(latitude: 22.5726, longitude: 88.3639)
        ))
        AF.request(url!).responseData { (response) in
            self.currentWeather = CurrentWeather.fromData(response.data!)
            print(self.currentWeather.toString())
            completed()
        }
    }
    
    func getWeatherForecast(completed: @escaping DownloadComplete) {
        let fetchOptions = WeatherFetchOptions(latitude: 22.5726, longitude: 88.3639, exclude: [
            .current, .alerts, .hourly, .minutely
        ])
        let url = URL(string: _getOneCallUrl(fetchOptions: fetchOptions))

        AF.request(url!).responseData { (response) in
            WeatherForecast.loadDataAsync(response.data!) { (hlt, forecasts) in
                self.highLowToday = hlt
                self.weatherForecasts = forecasts
                completed()
            }
        }
    }
}
