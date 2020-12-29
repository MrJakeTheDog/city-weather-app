//
//  ViewController.swift
//  CityWeatherApp
//
//  Created by Mr Jake on 30.11.2020.
//  Copyright © 2020 Demchenko inc. All rights reserved.
//

import UIKit
import DrawerView

class ViewController: UIViewController {

    let weatherStatus: [String] = ["Sun", "Cloudly", "Night", "Lightning", "Rain"]
    var counter = 0

    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var smallCloudImage: UIImageView!
    @IBOutlet weak var bigCloudImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 15

        let drawerView = DrawerView()
           drawerView.attachTo(view: self.view)


        drawerView.snapPositions = [.partiallyOpen, .open]
        drawerView.position = .partiallyOpen
        drawerView.cornerRadius = 25
    }


    @IBAction func updateWeather(_ sender: UIButton) {

        let selectedWeather: String = weatherStatus[counter]

        switch selectedWeather {
        case "Sun":
            sunAnimation()
            print("Sun")
            counter+=1
        case "Cloudly":
            sunAnimationExit()
            print("Cloudly")
            counter-=1
        case "Night":
            print("Night")
        case "Lightning":
            print("Lightning")
        case "Rain":
            print("Rain")
        default:
            print("Nothing")
        }
    }

    func sunAnimation() {
        var frameBigCloud = self.bigCloudImage.frame
        frameBigCloud.origin.x = 53
        var frameSmallCloud = self.smallCloudImage.frame
        frameSmallCloud.origin.x = 203

        var frame = self.sunImage.frame
        frame.origin.y = 25
        frame.origin.x = 100
        frame.size.height = 175
        frame.size.width = 180

        self.sunImage.image = UIImage(named: "Sun")
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
        self.bigCloudImage.frame = frameBigCloud
            self.smallCloudImage.frame = frameSmallCloud
        self.sunImage.frame = frame
        }){ (true) in
        print("Done")
        }
    }

    func sunAnimationExit() {
        var frameBigCloud = self.bigCloudImage.frame
        frameBigCloud.origin.x = -170
        var frameSmallCloud = self.smallCloudImage.frame
        frameSmallCloud.origin.x = 403

        var frame = self.sunImage.frame
        frame.origin.y = 112.67
        frame.origin.x = 190
        frame.size.height = 1
        frame.size.width = 1

        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseIn, animations: {
        self.bigCloudImage.frame = frameBigCloud
        self.smallCloudImage.frame = frameSmallCloud
        self.sunImage.frame = frame
        }){ (true) in
        print("Done")
        self.sunImage.image = nil
        }
    }


}

