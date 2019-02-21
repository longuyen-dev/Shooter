//
//  ViewController.swift
//  Shooter
//
//  Created by Mr.Long on 2/5/19.
//  Copyright © 2019 LoNguyen. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    var timer = Timer()
    var turn:CGFloat = 1
    var degree: CGFloat = 20
    var locationOfTargerArray = [0,90,180,270]
    var locationOfTarget = 0
    var point = 0
    var check = false
    var level = 0.01
    var cookie = UserDefaults.standard
    var highScore = 0
    var shooter: UIImageView = {
        let imv = UIImageView()
        
        let img = UIImage(named: "shooter")
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = img
        
        return imv
    }()
    var coin: UIImageView = {
        let imv = UIImageView()
        
        let img = UIImage(named: "coin")
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = img
        
        return imv
    }()
    var replay: UIImageView = {
        let imv = UIImageView()
        
        let img = UIImage(named: "replay")
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = img
        
        return imv
    }()
    var targetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var shooterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return view
    }()
    var pointLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "0"
        l.textAlignment = .center
        l.font = UIFont(name: "Noteworthy-Bold", size: 40)
        return l
    }()
    
    var highScoreLb: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Best Score: 0"
        l.textAlignment = .center
        l.font = UIFont(name: "Noteworthy-Bold", size: 40)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScore = cookie.integer(forKey: "highScore")
        
        setupTargetView()
        
        setupShooterView()
        
        rotationShooter()
        
        setupPointLabel()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeTurn)))
        replay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(replayAction(tapGestureRecognizer: ))))
        replay.isUserInteractionEnabled = true
    }
    @objc func changeTurn(){
        let distance = abs(Int(degree) - locationOfTarget)
        if (distance >= 0 && distance <= 10) || (distance >= 350 && distance <= 360){
            point += 1
            pointLabel.text = String(point)
            check = false
            
            let gen = UINotificationFeedbackGenerator()
            gen.notificationOccurred(.error)
            turn *= -1
            
            if point % 3 == 0 {
                level -= 0.0005
            }
            timer.invalidate()
            rotationShooter()
            while(true){
                let randomInt = Int.random(in: 0...3)
                if locationOfTarget != locationOfTargerArray[randomInt]{
                    locationOfTarget = locationOfTargerArray[randomInt]
                    break
                }
                    
            }
            
            targetView.transform = CGAffineTransform(rotationAngle: CGFloat(locationOfTarget) * (.pi/180))
            coin.frame.size.width = 0
            coin.frame.size.height = 0
            UIImageView.animate(withDuration: 0.3, animations: {
                self.coin.frame.size.width += (self.view.frame.size.width) / 8
                self.coin.frame.size.height += (self.view.frame.size.width) / 8
            })
        }else{
            lose()
            
        }
    }
    @objc func replayAction(tapGestureRecognizer: UITapGestureRecognizer){
        point = 0
        turn = 1
        degree = 20
        level = 0.01
        locationOfTarget = 0
        targetView.transform = CGAffineTransform(rotationAngle: CGFloat(locationOfTarget) * (.pi/180))
        shooterView.transform = CGAffineTransform(rotationAngle: degree * (.pi/180))
        pointLabel.text = String(point)
        rotationShooter()
        
        replay.removeFromSuperview()
    }
    func lose(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.check = false
        self.timer.invalidate()
        setupReplayButton()
        
        if point > highScore{
            highScore = point
            cookie.set(highScore, forKey: "highScore")
            highScoreLb.text = "Best Score: \(highScore)"
        }
        
    }
    func setupTargetView(){
        view.addSubview(targetView)
        
        targetView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        targetView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        targetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        targetView.addSubview(coin)
        coin.widthAnchor.constraint(equalTo: targetView.widthAnchor, multiplier: 1/8).isActive = true
        coin.heightAnchor.constraint(equalTo: targetView.widthAnchor, multiplier: 1/8).isActive = true
        coin.centerXAnchor.constraint(equalTo: targetView.centerXAnchor).isActive = true
        coin.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 10).isActive = true
    }
    func setupShooterView(){
        view.addSubview(shooterView)
        
        shooterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        shooterView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        shooterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shooterView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        shooterView.addSubview(shooter)
        shooter.widthAnchor.constraint(equalTo: shooterView.widthAnchor, multiplier: 1/4).isActive = true
        shooter.heightAnchor.constraint(equalTo: shooterView.widthAnchor, multiplier: 1/4).isActive = true
        shooter.centerXAnchor.constraint(equalTo: shooterView.centerXAnchor).isActive = true
        shooter.topAnchor.constraint(equalTo: shooterView.topAnchor).isActive = true
        
        shooterView.transform = CGAffineTransform(rotationAngle: degree * (.pi/180))
    }
    func setupReplayButton(){
        view.addSubview(replay)
        replay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replay.widthAnchor.constraint(equalTo: shooter.widthAnchor).isActive = true
        replay.heightAnchor.constraint(equalTo: shooter.widthAnchor).isActive = true
        replay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    func setupPointLabel(){
        view.addSubview(pointLabel)
        
        pointLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        pointLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        pointLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pointLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(highScoreLb)
        
        highScoreLb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        highScoreLb.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        highScoreLb.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        
        highScoreLb.text = "Best Score: \(highScore)"
    }
    
    func rotationShooter(){
        
        timer = Timer(timeInterval: level, repeats: true, block: { (t) in
            let distance = abs(Int(self.degree) - self.locationOfTarget)
            let inSafeArea =  (distance >= 0 && distance <= 10) || (distance >= 350 && distance <= 360)
            if inSafeArea {
                self.check = true
            }
            if self.check && !inSafeArea{
                
                
                self.lose()
            }
            
            self.shooterView.transform = CGAffineTransform(rotationAngle: self.degree * (.pi/180))
            
            
            if (self.turn == 1 && self.degree == 359) {
                self.degree = 0
            }else{
                if (self.turn == -1 && self.degree == 1) {
                    self.degree = 360
                }else{
                    self.degree += self.turn
                }
                
            }
            
        })
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        
        
    }


}

