//
//  WeatherViewController.swift
//  WeatherMate
//
//  Created by Jyotiprakash Roy on 25/11/21.
//

import Cocoa

class WeatherViewController: NSViewController {

    // Storyboard element <-> View Controller Connection
    // basically getElementById in JS
    @IBOutlet weak var mainTemperatureLabel: NSTextField!
    @IBOutlet weak var userLocationLabel: NSTextField!
    @IBOutlet weak var lowHighTempLabel: NSTextField!
    @IBOutlet weak var humidityLabel: NSTextField!
    @IBOutlet weak var feelsLikeLabel: NSTextField!
    @IBOutlet weak var weatherConditionLabel: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var weatherImage: NSImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        updateUI()
    }

    func updateUI() {
        let weather = WeatherService.instance.currentWeather
        let highLowToday = WeatherService.instance.highLowToday
        
        //TODO: Do something about units
        
        mainTemperatureLabel.stringValue = "\(weather.currentTemp)°C"
        userLocationLabel.stringValue = "\(weather.cityName), \(weather.countryCode)"
        lowHighTempLabel.stringValue = "\(highLowToday[1])°C Low, \(highLowToday[0])°C High"
        humidityLabel.stringValue = "Humidity: \(weather.humidity)%"
        feelsLikeLabel.stringValue = "Feels Like: \(weather.feelsLikeTemp)°C"
        weatherConditionLabel.stringValue = "\(weather.weatherCondition)"
        weatherImage.image = NSImage(named: "Clouds")   //FIXME: Find missing Images (for like: mist etc.)
    }
}


extension WeatherViewController: NSCollectionViewDelegate, NSCollectionViewDataSource,
    NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView,
          itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let forecastItem = collectionView
            .makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "WeatherCell"), for: indexPath)
        
        guard let forecastCell = forecastItem as? WeatherCell else { return forecastItem }
        forecastCell.configureCell(forecast: WeatherService.instance.weatherForecasts[indexPath.item])
        
        return forecastCell
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherService.instance.weatherForecasts.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 55, height: 55)
    }
}
