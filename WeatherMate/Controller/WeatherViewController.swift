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
    @IBOutlet weak var airQualityIndexLabel: NSTextField!
    @IBOutlet weak var weatherConditionLabel: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


extension WeatherViewController: NSCollectionViewDelegate, NSCollectionViewDataSource,
    NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let forecastItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "WeatherCell"), for: indexPath)
        
        return forecastItem
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 55, height: 55)
    }
}
