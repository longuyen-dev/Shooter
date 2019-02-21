//
//  MenuViewController.swift
//  Shooter
//
//  Created by Mr.Long on 2/21/19.
//  Copyright © 2019 LoNguyen. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var timer = Timer()
    var turn:CGFloat = 1
    var degree:CGFloat = 0
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        lb.text = "Shooter"
        lb.font = UIFont(name: "Noteworthy-Light", size: 39)
        lb.textAlignment = .center
        lb.textColor = #colorLiteral(red: 0.950178206, green: 0.4290649593, blue: 0.32590729, alpha: 1)
        return lb
    }()
    var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    var playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.addTarget(self, action: #selector(gotoPlayScreen), for: .touchUpInside)
        return btn
    }()
    
    var facebookButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "f"), for: .normal)
        
        return btn
    }()
    
    var twitterButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "t"), for: .normal)
        
        return btn
    }()
    
    var zaloButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "z"), for: .normal)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupImplement()
        
        rotatingPlayButton()
        
    }
    
    func setupImplement(){
        view.addSubview(titleLabel)
        
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(containerView)
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        containerView.addSubview(playButton)
        
        playButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        playButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(facebookButton)
        
        facebookButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        facebookButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(twitterButton)
        
        twitterButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        twitterButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        twitterButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor).isActive = true
        twitterButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: (view.frame.size.width / 7)).isActive = true
        
        containerView.addSubview(zaloButton)
        
        zaloButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        zaloButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/7).isActive = true
        zaloButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor).isActive = true
        zaloButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -(view.frame.size.width / 7)).isActive = true
        
        
        
        

    }
    @objc func gotoPlayScreen(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func rotatingPlayButton(){
        timer = Timer(timeInterval: 0.01, repeats: true, block: { (t) in
            self.playButton.transform = CGAffineTransform(rotationAngle: self.degree * (.pi/180))
            if (self.turn == 1 && self.degree == 359) {
                self.degree = 0
            }else{
                if (self.turn == -1 && self.degree == 1) {
                    self.degree = 360
                }else{
                    self.degree += self.turn
                }
                
            }
            if self.degree == 260 {
                UIButton.animate(withDuration: 0.3, animations: {
                    self.facebookButton.frame.size.width = self.facebookButton.frame.size.width + 10
                    self.facebookButton.frame.size.height = self.facebookButton.frame.size.height + 10
                    
                })
                let queue = DispatchQueue(label: "q1")
                queue.asyncAfter(deadline: .now() + 0.3, execute: {
                    UIButton.animate(withDuration: 0.3, animations: {
                        
                        DispatchQueue.main.sync {
                            self.facebookButton.frame.size.width = self.facebookButton.frame.size.width - 10
                            self.facebookButton.frame.size.height = self.facebookButton.frame.size.height - 10
                        }
                        
                    })
                })
            }
            
            if self.degree == 218 {
                UIButton.animate(withDuration: 0.3, animations: {
                    self.twitterButton.frame.size.width = self.twitterButton.frame.size.width + 10
                    self.twitterButton.frame.size.height = self.twitterButton.frame.size.height + 10
                    
                })
                let queue = DispatchQueue(label: "q1")
                queue.asyncAfter(deadline: .now() + 0.3, execute: {
                    UIButton.animate(withDuration: 0.3, animations: {
                        
                        DispatchQueue.main.sync {
                            self.twitterButton.frame.size.width = self.twitterButton.frame.size.width - 10
                            self.twitterButton.frame.size.height = self.twitterButton.frame.size.height - 10
                        }
                        
                    })
                })
            }
            
            if self.degree == 305 {
                UIButton.animate(withDuration: 0.3, animations: {
                    self.zaloButton.frame.size.width = self.zaloButton.frame.size.width + 10
                    self.zaloButton.frame.size.height = self.zaloButton.frame.size.height + 10
                    
                })
                let queue = DispatchQueue(label: "q1")
                queue.asyncAfter(deadline: .now() + 0.3, execute: {
                    UIButton.animate(withDuration: 0.3, animations: {
                        
                        DispatchQueue.main.sync {
                            self.zaloButton.frame.size.width = self.zaloButton.frame.size.width - 10
                            self.zaloButton.frame.size.height = self.zaloButton.frame.size.height - 10
                        }
                        
                    })
                })
                
            }
            
            
        })
        RunLoop.current.add(timer, forMode: .default)
    }
    


}
