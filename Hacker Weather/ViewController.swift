//
//  ViewController.swift
//  Hacker Weather
//
//  Created by Akhil Waghmare on 10/20/17.
//  Copyright © 2017 AW Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Connections to UI
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageOverlay: UIView!
    
    // Weather object containing current information presented to user
    var weather: Weather? {
        didSet {
            updateUI()
        }
    }
    
    // URL for json file with weather information
    private let apiUrl = "http://awlabs.tech/api/hackharvard17/weather.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        weather = Weather(location: "Cambridge, MA", temperature: 67, precipChance: 0.00, humidity: 0.37, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/c/c7/Memorial_Hall_%28Harvard_University%29_-_facade_view.JPG")
    }
    
    // Make the status bar information white (to look better on dark content)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Action for when refresh button is tapped
    @IBAction func refreshWeather(_ sender: Any) {
        fetchWeather()
    }
    
}

private extension ViewController {
    
    // Initial UI setup
    func setupUI() {
        imageOverlay.alpha = 0.5
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    // Update UI with new weather information
    func updateUI() {
        guard let weather = weather else {
            return
        }
        
        fetchImage(from: weather.imageUrl)
        
        DispatchQueue.main.async {
            UIView.transition(with: self.locationLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.locationLabel.text = weather.location
            }, completion: nil)
            
            UIView.transition(with: self.temperatureLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.temperatureLabel.text = "\(weather.temperature)˚"
            }, completion: nil)
            
            UIView.transition(with: self.precipLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.precipLabel.text = "Chance of precipitation: \(Int(weather.precipChance * 100))%"
            }, completion: nil)
            
            UIView.transition(with: self.humidityLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.humidityLabel.text = "Humidity: \(Int(weather.humidity * 100))%"
            }, completion: nil)
        }
    }
    
    // General function for fetching an image from URL
    func fetchImage(from imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            let fetchedImage = UIImage(data: data)
            DispatchQueue.main.async {
                UIView.transition(with: self.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.backgroundImageView.image = fetchedImage
                }, completion: nil)
            }
        }
        task.resume()
    }
    
    // Fetching weather information from URL. Resulting JSON is directly decoded to Weather struct.
    func fetchWeather() {
        guard let url = URL(string: apiUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            
            do {
                let newWeather = try JSONDecoder().decode(Weather.self, from: data)
                self.weather = newWeather
            } catch let err {
                print(err.localizedDescription)
            }
            
        }.resume()
    }
}
