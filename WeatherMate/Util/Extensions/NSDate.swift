//
//  NSDate.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 29/11/21.
//

import Foundation

extension Date {
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
}
