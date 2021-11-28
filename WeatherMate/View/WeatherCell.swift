//
//  WeatherCell.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 26/11/21.
//

import Cocoa

class WeatherCell: NSCollectionViewItem {
    
    @IBOutlet weak var weatherCellImage: NSImageView!
    @IBOutlet weak var weatherCellDate: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func configureCell(forecast: WeatherForecast) {
        weatherCellDate.stringValue = forecast.date
        weatherCellImage.image = NSImage(named: forecast.weatherType) //FIXME: -_-
    }
}
