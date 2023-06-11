//
//  ViewController.swift
//  Egg Timer
//
//  Created by Administrator on 11/06/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    
    let softTime = 5, mediumTime = 7, hardTime = 12
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        var time : Int?
        print(sender.currentTitle)
        if let title = sender.currentTitle {
            time = eggTimes[title]
//            switch (title) {
//            case "Hard":
//                time = hardTime
//            case "Medium":
//                time = mediumTime
//            case "Soft":
//                time = softTime
//            default:
//                time = nil
//            }
            print(time)
            if var validTime = time {
                countDown2(seconds: validTime)
            } else {
                print("Error")
            }
        }
        if let t = time {
        } else {
            print("I don't now.")
        }
    }
    
    var count : Int = 0
    var full : Int = 0
    var player : AVAudioPlayer?
    
    func countDown2(seconds: Int) {
        full = seconds
        count = seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var progress: UIProgressView!
    
    func countDown1(seconds: Int) {
        var s = seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tm -> Void in
                
                if s == 0 {
                    print(s)
                    self.titleLabel.text = "Done"
                    tm.invalidate()
                } else {
                    print(s)
                    self.titleLabel.text = String(s)
                    s = s - 1
                }
            }
    }
    
    @objc func update() {
        progress.setProgress(Float(full - count) / Float(full), animated: true)
        if (count == 0) {
            timer.invalidate()
            playSound(name: "F")
            titleLabel.text = "Done"
        } else {
            titleLabel.text = String(count)
            count -= 1
        }
    }
    
    func playSound(name : String) {
        
        guard let path = Bundle.main.path(forResource: name, ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
