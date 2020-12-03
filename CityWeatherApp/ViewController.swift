//
//  ViewController.swift
//  CityWeatherApp
//
//  Created by Mr Jake on 30.11.2020.
//  Copyright © 2020 Demchenko inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var smallCloudImage: UIImageView!
    @IBOutlet weak var bigCloudImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 15
    }


    @IBAction func updateWeather(_ sender: UIButton) {

        //bigCloudImage.layer.position.y = 90
        //bigCloudImage.layer.position.x = -170

        var frameBigCloud = self.bigCloudImage.frame
        frameBigCloud.origin.x = 53
        var frameSmallCloud = self.smallCloudImage.frame
        frameSmallCloud.origin.x = 203

        var frame = self.sunImage.frame
        frame.origin.y = 25
        frame.origin.x = 100
        frame.size.height = 175
        frame.size.width = 180

        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
        self.bigCloudImage.frame = frameBigCloud
            self.smallCloudImage.frame = frameSmallCloud
        self.sunImage.frame = frame
        }){ (true) in
        print("Done")
        }
    }


}

