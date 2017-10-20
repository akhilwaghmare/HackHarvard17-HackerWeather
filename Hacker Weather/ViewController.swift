//
//  ViewController.swift
//  Hacker Weather
//
//  Created by Akhil Waghmare on 10/20/17.
//  Copyright © 2017 AW Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageOverlay: UIView!
    
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weather = Weather(location: "Cambridge, MA", temperature: 76, precipChance: 20.5, imageUrlString: "https://upload.wikimedia.org/wikipedia/commons/c/c7/Memorial_Hall_%28Harvard_University%29_-_facade_view.JPG")
        imageOverlay.backgroundColor = .black
        imageOverlay.alpha = 0.5
        updateUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

private extension ViewController {
    
    func updateUI() {
        guard let weather = weather else {
            return
        }
        locationLabel.text = weather.location
        temperatureLabel.text = "\(weather.temperature)˚"
        precipLabel.text = "Chance of precipitation: \(weather.precipChance)%"
        fetchImage(from: weather.imageUrlString)
    }
    
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
                //self.backgroundImageView.image = fetchedImage
                self.backgroundImageView.contentMode = .scaleAspectFill
                
                UIView.transition(with: self.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.backgroundImageView.image = fetchedImage
                }, completion: nil)
            }
        }
        task.resume()
    }
}
