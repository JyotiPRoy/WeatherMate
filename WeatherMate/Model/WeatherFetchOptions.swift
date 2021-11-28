//
//  WeatherFetchOptions.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 28/11/21.
//

import Foundation

struct WeatherFetchOptions {
    
    let latitude: Double!
    let longitude: Double!
    let unit: MeasurementUnit!
    var exclude: [ExcludeOptions]!
    
    // Options for default Current Weather + Metric Units
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.unit = .metric
        self.exclude = Array(ExcludeOptions.allCases.drop { option in
            return option == .current
        })
    }
    
    init(latitude: Double, longitude: Double, exclude: [ExcludeOptions]) {
        self.latitude = latitude
        self.longitude = longitude
        self.unit = .metric
        self.exclude = exclude
    }
    
    init(latitude: Double, longitude: Double, unit: MeasurementUnit, exclude: [ExcludeOptions]) {
        self.latitude = latitude
        self.longitude = longitude
        self.unit = unit
        self.exclude = exclude
    }
    
    func getExcludeAsString() -> String {
        var res: String = ""
        exclude.forEach { option in
            res += option.rawValue + ","
        }
        return String(res.dropLast())
    }
}
