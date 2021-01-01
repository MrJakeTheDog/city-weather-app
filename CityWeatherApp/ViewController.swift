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
    var labelArray: [UILabel] = []
    var labelTempretureArray: [UILabel] = []
    var imageArray: [UIImageView] = []

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

        let textToday = UILabel(frame: CGRect(x: 20, y: 95, width: 75, height: 30))
        textToday.text = "Today"
        textToday.font = UIFont(name: "JosefinSans-Bold", size: 18)


        let buttonNext = UIButton(frame: CGRect(x: drawerView.bounds.width-130, y: 95, width: 130, height: 30))
        buttonNext.setTitle("Next 7 days", for: .normal)
        buttonNext.setTitleColor(#colorLiteral(red: 0.3095738292, green: 0.3689167798, blue: 0.8828716874, alpha: 1), for: .normal)
        buttonNext.titleLabel?.font = UIFont(name: "JosefinSans-Bold", size: 18)

        let textNext = UILabel(frame: CGRect(x: drawerView.bounds.width-120, y: 100, width: 100, height: 30))
        textNext.text = "Next 7 days"
        textNext.textColor = #colorLiteral(red: 0.3095738292, green: 0.3689167798, blue: 0.8828716874, alpha: 1)
        textNext.font = UIFont(name: "JosefinSans-Bold", size: 16)
        drawerView.addSubview(textToday)
        drawerView.addSubview(buttonNext)

        for i in 0...4 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            let simularView = UIView(frame: CGRect(x: 12+drawerView.bounds.width/5 * CGFloat(i), y: 150, width: 55, height: 85))
            simularView.tag = i
            simularView.layer.cornerRadius = 15
            simularView.layer.masksToBounds = true
            simularView.layer.borderColor = #colorLiteral(red: 0.7344815422, green: 0.7344815422, blue: 0.7344815422, alpha: 1)
            simularView.layer.borderWidth = 2
            simularView.addGestureRecognizer(tap)
            viewArray.append(simularView)
            drawerView.addSubview(viewArray[i])

            let simularLabel = UILabel(frame: CGRect(x: 0, y: 10, width: simularView.bounds.width, height: 20))
            let time: String = String(19 + i) + ":00"
            simularLabel.text = time
            simularLabel.textAlignment = .center
            simularLabel.font = UIFont(name: "JosefinSans-SemiBold", size: 16)
            simularLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            labelArray.append(simularLabel)
            simularView.addSubview(simularLabel)

            let simularTempretureLabel = UILabel(frame: CGRect(x: 0, y: simularView.bounds.height-25, width: simularView.bounds.width, height: 20))
            let tempreture = String(19-i) + "°"
            simularTempretureLabel.text = tempreture
            simularTempretureLabel.textAlignment = .center
            simularTempretureLabel.font = UIFont(name: "JosefinSans-SemiBold", size: 16)
            simularTempretureLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            labelTempretureArray.append(simularTempretureLabel)
            simularView.addSubview(simularTempretureLabel)

            let tempretureImage = UIImageView(frame: CGRect(x: 20, y: simularView.bounds.width/2, width: simularView.bounds.width-40, height: 30))
            tempretureImage.image = UIImage(named: "cloudStandart")
            imageArray.append(tempretureImage)
            simularView.addSubview(tempretureImage)
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        for i in 0...4 {
            UIView.animate(withDuration: 0.2) {
                self.viewArray[i].backgroundColor = .white
                self.viewArray[i].layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.labelArray[i].textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                self.labelTempretureArray[i].textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        }

        UIView.animate(withDuration: 0.2) {
            sender?.view?.backgroundColor = #colorLiteral(red: 0.2917807996, green: 0.3460126817, blue: 0.8788960576, alpha: 1)
            sender?.view?.layer.borderColor = #colorLiteral(red: 0.2917807996, green: 0.3460126817, blue: 0.8788960576, alpha: 1)
            self.labelArray[(sender?.view!.tag)!].textColor = .white
            self.labelTempretureArray[(sender?.view?.tag)!].textColor = .white
        }

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

