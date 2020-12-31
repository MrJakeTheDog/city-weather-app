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

    var viewArray: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 15

        let drawerView = DrawerView()
           drawerView.attachTo(view: self.view)


        drawerView.snapPositions = [.partiallyOpen, .open]
        drawerView.position = .partiallyOpen
        drawerView.cornerRadius = 30
        drawerView.backgroundColor = .white

        let graphicProggressView = UIProgressView(frame: CGRect(x: drawerView.frame.width/2 - 40, y: 40, width: 90, height: 5))

        graphicProggressView.progress = 100
        graphicProggressView.progressTintColor = #colorLiteral(red: 0.1853383482, green: 0.2678459585, blue: 0.870508492, alpha: 1)
        graphicProggressView.transform = graphicProggressView.transform.scaledBy(x: 1, y: 1.15)

        drawerView.addSubview(graphicProggressView)

        for i in 0...4 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            let simularView = UIView(frame: CGRect(x: 12+drawerView.bounds.width/5 * CGFloat(i), y: 150, width: 55, height: 85))
            simularView.layer.cornerRadius = 15
            simularView.layer.masksToBounds = true
            simularView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            simularView.layer.borderWidth = 2
            simularView.addGestureRecognizer(tap)
            viewArray.append(simularView)
            drawerView.addSubview(viewArray[i])
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        for i in 0...4 {
            viewArray[i].backgroundColor = .white
            viewArray[i].layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        sender?.view?.backgroundColor = #colorLiteral(red: 0.2917807996, green: 0.3460126817, blue: 0.8788960576, alpha: 1)
        sender?.view?.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    @IBAction func updateWeather(_ sender: UIButton) {

        let selectedWeather: String = weatherStatus[counter]

        switch selectedWeather {
        case "Sun":
            sunAnimation()
            print("Sun")
            counter += 1
        case "Cloudly":
            sunAnimationExit()
            print("Cloudly")
            counter -= 1
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

