//
//  ViewController.swift
//  bullseye
//
//  Created by yash kanani on 09/04/15.
//  Copyright (c) 2015 yash kanani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 50
    var targetValue: Int = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted"); slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") { let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets); slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal) }
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showalert(){
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        /*let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe Difference is: \(difference)"*/
        var title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not even close!"
        }
        score += points
        let message = "you scored \(points) points"
        
        let alert = UIAlertController(title: title,
            message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in self.startNewRound()
            self.updateLabels()
            })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func sliderMoved(slider: UISlider){
            currentValue = lroundf(slider.value)
    }
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }
    func updateLabels() {
            targetLabel.text = String(targetValue)
            scoreLabel.text = String(score)
            roundLabel.text = String(round)
    }
    func startNewGame() {
                round = 0
                score = 0
                startNewRound()
    }
}

