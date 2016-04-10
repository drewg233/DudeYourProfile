//
//  ViewController.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit
import Spring

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loginWithFacebookButton: UIButton!
    @IBOutlet weak var logoImage: SpringImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginWithFacebookButton.layer.cornerRadius = 3
        
        logoImage.animation = "squeezeDown"
        logoImage.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    


}

